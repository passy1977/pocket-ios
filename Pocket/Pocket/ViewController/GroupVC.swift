/***************************************************************************
 *
 * Pocket
 * Copyright (C) 2018/2025 Antonio Salsi <passy.linux@zresa.it>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 ***************************************************************************/

import UIKit
import Reachability
import SwiftSpinner

final class GroupVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    //MARK: - IBOutlet
    @IBOutlet private weak var txtGroupTitle: UITextField!
    @IBOutlet private weak var txtViwGroupNote: SZTextView!
    @IBOutlet private weak var txtGroupFieldTitle: UITextField!
    @IBOutlet private weak var switchGroupFieldIsHidden: UISwitch!
    @IBOutlet private weak var btnGroupAdd: UIBarButtonItem!
    @IBOutlet private weak var btnGroupFieldAdd: UIButton!
    @IBOutlet private weak var btnGroupFieldClear: UIButton!
    @IBOutlet private weak var list: UITableView!
    
    //MARK: - Data
    private let reachability = try! Reachability()
    private let controller = GroupController()
    
    private var groupFieldList : [GroupField] = []
    
    private var insert = true
    private var groupFieldToModify: GroupField? = nil
    
    private var idGroupFieldToModify : UInt32 = 1;
    
    public weak var group : Group? = nil {
        didSet {
            insert = (group?.title ?? "") == ""
        }
    }
    
    //MARK: - system
    override func viewDidLoad() {
        super.viewDidLoad()
        btnGroupAdd.isEnabled = false
        txtViwGroupNote.isEditable = false
        setGroupField(enable: false)
        
        controller.initialize()
        
        if let group = group {
            controller.fillShowList(group, insert: insert);
        }
        idGroupFieldToModify = controller.getLastIdGroupField();
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
          try reachability.startNotifier()
        }catch{
          print("could not start reachability notifier:\(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let group = self.group else {
            alertShow(self, title: "Error", message: "Reference group nil")
            return
        }
        
        if insert {
            btnGroupAdd.isEnabled = false
            txtViwGroupNote.isEditable = false
        } else {
            insert = false
            btnGroupAdd.isEnabled = true
            txtViwGroupNote.isEditable = true
            txtGroupTitle.text = group.title
            txtViwGroupNote.text = group.note
        }
        
        reloadList(group._id, insert: insert)
        
//        Timeout4Logout.getShared().updateTimeLeft()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            group = nil
        }
    }

    //MARK: - Back
    
    override func didMove(toParent parent: UIViewController?) {
        if !(parent?.isEqual(self.parent) ?? false) {
            controller.cleanShowList()
        }
        super.didMove(toParent: parent)
    }
    
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    @inlinable
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupFieldList.count
    }
    
    //data in cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupFieldCell", for: indexPath)
        let groupField = groupFieldList[indexPath.row]
        
        cell.textLabel?.text = groupField.title

        return cell
    }
    
    //tap
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        let groupField = groupFieldList[indexPath.row]
        
        groupFieldToModify = groupField
        
        setGroupField(enable: true, title: groupField.title, isHidden: groupField.isHidden)
    }


    //swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        view.endEditing(true)
        //delete
        let delete = UIContextualAction(style: .destructive, title: nil) { _, _, success in
            alertShow(self, title: "Warning", message: "Dou you want delete it?", handlerNo: { _ in success(false)}) { _ in

                if self.controller.del(fromShowList: self.groupFieldList[indexPath.row]._id)
                {
                    DispatchQueue.main.async {
                        self.reloadList(self.group?._id ?? 0, insert: self.insert)
                    }
                }
            }
        }
        delete.backgroundColor = .red
        delete.image = UIImage(systemName: "trash")
        
        let ret = UISwipeActionsConfiguration(actions: [delete])
        ret.performsFirstActionWithFullSwipe = false
        return ret
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Reachability
    
    @objc func reachabilityChanged(note: Notification) {
      if let reachability = note.object as? Reachability, reachability.connection == .unavailable {
        print("Network not reachable")
          controller.reachability = false;
      } else {
          controller.reachability = true;
      }
    }
    
    // MARK: - Act
    
    @IBAction func actBtnGroupAdd(_ sender: UIBarButtonItem) {
        guard let group = self.group else {
            return
        }
        if txtGroupFieldTitle.text != "" {
            alertShow(self, message: "Not all data are saved!")
            return
        }
        
        
        //                            Timeout4Logout.getShared().start()
        if insert {
            let g = Group()
            g.groupId = group._id
            g.serverGroupId = group.serverId
            g.title = txtGroupTitle.text ?? ""
            g.note = txtViwGroupNote.text ?? ""
            g.icon = ""
            GroupsFieldsVC.overrideSearch = g.title
            
            SwiftSpinner.show("Synchronize to server...")
            
            DispatchQueue.global(qos: .background).async {
                
                self.controller.persistGroup(g)
                self.group = g
                
                DispatchQueue.main.async {
                    SwiftSpinner.hide()
                    self.navigationController?.popViewController(animated: true)
                }
                
                
            }
        } else {
            group.title = txtGroupTitle.text ?? ""
            group.note = txtViwGroupNote.text ?? ""
            GroupsFieldsVC.overrideSearch = group.title
            SwiftSpinner.show("Synchronize to server...")
            
            DispatchQueue.global(qos: .background).async {
                self.controller.persistGroup(group)
                DispatchQueue.main.async {
                    SwiftSpinner.hide()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    
    @IBAction func actBtnGroupFieldAdd(_ sender: UIButton) {
        guard let group = self.group else {
            return
        }
        
        let groupField = GroupField()
        
        if let groupFieldToModify = self.groupFieldToModify  {
            groupField._id = groupFieldToModify._id
            groupField.serverId = groupFieldToModify.serverId
        } else {
            idGroupFieldToModify += 1
            groupField.newInsertion = true;
            groupField._id = idGroupFieldToModify
        }
        
        groupField.title = txtGroupFieldTitle.text ?? ""
        groupField.isHidden = switchGroupFieldIsHidden.isOn
        
        if(controller.add(toShowList: groupField))
        {
            groupFieldToModify = nil;
            self.setGroupField(enable: false)
        }
        
        reloadList(group._id, insert: insert)
    }
    
    @IBAction func actBtnGroupFieldClear(_ sender: UIButton) {
        groupFieldToModify = nil
        self.setGroupField(enable: false)
    }
    
    @IBAction func actTxtFieldChange(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        if text.isEmpty {
            sender.setBottomBorderOnlyWith()
        } else {
            sender.unsetBottomBorderOnlyWith()
        }
        if sender == txtGroupTitle {
            btnGroupAdd.isEnabled = !(sender.text?.isEmpty ?? true)
            txtViwGroupNote.isEditable = !(sender.text?.isEmpty ?? true)
        } else if sender == txtGroupFieldTitle {
            let check = !(sender.text?.isEmpty ?? true)
            btnGroupFieldAdd.isEnabled = check
            btnGroupFieldClear.isEnabled = check
            switchGroupFieldIsHidden.isEnabled = check
            
        }
    }
    
    // MARK: - Function
    
    private func setGroupField(enable: Bool, title: String = "",  isHidden : Bool? = nil) {
        txtGroupFieldTitle.text = title
        btnGroupFieldAdd.isEnabled = enable
        btnGroupFieldClear.isEnabled = enable
        switchGroupFieldIsHidden.isEnabled = enable
        switchGroupFieldIsHidden.isOn = isHidden ?? false
    }
    
    private func reloadList(_ groupId: UInt32, insert : Bool = false) {
        groupFieldList = [GroupField]()
        
        for groupField in controller.getShowList() {
            groupFieldList.append(groupField)
        }

        list.reloadData()
    }
}
