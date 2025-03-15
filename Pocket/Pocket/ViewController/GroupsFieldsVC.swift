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

final class GroupsFieldsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    //MARK: - IBOutlet
    @IBOutlet private weak var srcSearch: UISearchBar!
    @IBOutlet private weak var txtViwNote: UITextView!
    @IBOutlet private weak var list: UITableView!
    @IBOutlet private weak var cnstTxtViwNoteHeight: NSLayoutConstraint!
    @IBOutlet private weak var viwMenu: UIView!
    @IBOutlet private weak var cnstViewMenu: NSLayoutConstraint!
    @IBOutlet private weak var txtMenuTitle: UILabel!
    @IBOutlet private weak var btnXmlImport: UIButton!
    @IBOutlet private weak var btnXmlExport: UIButton!
    
    //MARK: - Data
    private var tupleList : [(group: Group?, field: Field?)] = []
    
    private let reachability = try! Reachability()
    private let groupController = GroupController()
    private let fieldController = FieldController()
    
    private(set) var group = Group()
    
    private var fieldForSegue : Field? = nil
    private var groupForSegue : Group? = nil
    
    static public var overrideSearch : String? = nil
    
    private let menuIconClose : UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.image = UIImage(systemName: "circle.grid.3x3")
        button.action = #selector(actViwMenuOpenOrClose)
        return button
    }()
    
    private let menuIconOpen : UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.image = UIImage(systemName: "circle.grid.3x3.fill")
        button.action = #selector(actViwMenuOpenOrClose)
        return button
    }()
    
    private let menuOffset : CGFloat = -195
    private var menuShowing = false
    
    private var fullPathFileXmlImport = ""
    
    //MARK: - system
    override func viewDidLoad() {
        super.viewDidLoad()
        srcSearch.delegate = self
        cnstViewMenu.constant = menuOffset
        txtMenuTitle.text = "Pocket \(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "")"
        menuIconClose.target = self
        menuIconOpen.target = self
        
        if let (group, search) = StackNavigator.share.peek {
            self.group = group
            txtViwNote.text = search
        }
        
        groupController.initialize()
        fieldController.initialize()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
          try reachability.startNotifier()
        } catch {
          print("could not start reachability notifier")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        cnstTxtViwNoteHeight.constant = group.note.isEmpty ? 0 : 128
        txtViwNote.text = group.note
        
        if !group.title.isEmpty {
            title = group.title
        }
        
        if StackNavigator.share.size() == 0 {
            menuShowing = false
            
            actViwMenuOpenOrClose(hideAnimation: true)
        } else {
            navigationItem.leftBarButtonItem = nil
        }
        
        if let overrideSearch = GroupsFieldsVC.overrideSearch {
            srcSearch.text = overrideSearch
            reloadList(group._id, search: overrideSearch)
            GroupsFieldsVC.overrideSearch = ""
        } else {
            reloadList(group._id, search: srcSearch.text ?? "")
        }
        
        Timeout4Logout.shared.callback = timeoutCallback
        Timeout4Logout.shared.updateTimeLeft()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        actViwMenuOpenOrClose(hideAnimation: true)
        
        if self.isMovingFromParent {
            if let (group, search) = StackNavigator.share.pop {
                //data will be loaded in viewWillAppear
                self.group = group
                srcSearch.text = search
            }
        }
    }
    
    //MARK: - Segue
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "field" {
            if let fieldVC = segue.destination as? FieldVC {
                fieldVC.field = fieldForSegue
                fieldVC.fieldController = fieldController
                fieldForSegue = nil
            }
        } else if segue.identifier == "group" {
            if let groupVC = segue.destination as? GroupVC {
                if let groupForSegue = self.groupForSegue {
                    groupVC.group = groupForSegue
                    fieldForSegue = nil
                } else {
                    group.title = ""
                    group.note = ""
                    groupVC.group = group
                }
           }
       }
    }
    
    @inlinable
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        false
    }
    
    
    // MARK: - UISearchBarDelegate
    @inlinable
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        reloadList(group._id, search: srcSearch.text ?? "")
        
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource
    @inlinable
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tupleList.count
    }
    
    //set cell value
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsFieldsVCCell.identifier, for: indexPath) as? GroupsFieldsVCCell else {
            return tableView.dequeueReusableCell(withIdentifier: GroupsFieldsVCCell.identifier, for: indexPath)
        }
        
        cell.father = self
        cell.groupController = groupController
        cell.fieldController = fieldController
        cell.tuple = tupleList[indexPath.row]
        
        return cell
    }
    

    //cell click
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupsFieldsVCCell.identifier)  else {
            return
        }
        view.endEditing(true)
        cell.selectionStyle = .none

        if let group = tupleList[indexPath.row].group {
            StackNavigator.share.push(group, search: srcSearch.text ?? "")
            actViwMenuOpenOrClose(hideAnimation: true)
            performSegue(withIdentifier: "groups", sender: self)
        }
    }

    //swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        view.endEditing(true)
        //delete
        let delete = UIContextualAction(style: .normal, title: nil) { _, _, success in
            alertShow(self, title: "Warning", message: "Dou you want delete it?", handlerNo: { _ in success(false)}) { _ in
                
                let tuple = self.tupleList[indexPath.row]
                
                Timeout4Logout.shared.stop()
                if let group = tuple.group {
                    
                    DispatchQueue.global(qos: .background).async {
                        self.groupController.delGroup(group)
                        DispatchQueue.main.async {
                            SwiftSpinner.hide()
                            self.reloadList(self.group._id)
                            Timeout4Logout.shared.start()
                        }
                    }
                    
                } else if let field = tuple.field {
                    DispatchQueue.global(qos: .background).async {
                        self.fieldController.delField(field)
                        DispatchQueue.main.async {
                            SwiftSpinner.hide()
                            self.reloadList(self.group._id)
                            Timeout4Logout.shared.start()
                        }
                    }
                    
                }
            }
        }
        delete.backgroundColor = .red
        delete.image = UIImage(systemName: "trash")
        
        //modify
        let modify = UIContextualAction(style: .normal, title: nil) { _, _, success in
            let tuple = self.tupleList[indexPath.row]
            self.actViwMenuOpenOrClose(hideAnimation: true)
            if let group = tuple.group  {
                self.groupForSegue = group
                self.performSegue(withIdentifier: "group", sender: self)
            } else if let field = tuple.field {
                self.fieldForSegue = field
                self.performSegue(withIdentifier: "field", sender: self)
            }

            success(true)
        }
        modify.backgroundColor = .blue
        modify.image = UIImage(systemName: "pencil")

        //copia testo
        if let field = self.tupleList[indexPath.row].field {
            let copy = UIContextualAction(style: .normal, title: "copy text") { _, _, success in
                
                UIPasteboard.general.string = field.value
                
                alertShow(self, message: "copied")
                
                success(true)
            }
            copy.backgroundColor = .darkGray
            copy.image = UIImage(systemName: "doc.on.doc")

            let ret = UISwipeActionsConfiguration(actions: [copy, modify, delete])
            ret.performsFirstActionWithFullSwipe = false
            return ret
        }

        let ret = UISwipeActionsConfiguration(actions: [modify, delete])
        ret.performsFirstActionWithFullSwipe = false
        return ret
    }
    // MARK: - Reachability
    
    @objc func reachabilityChanged(note: Notification) {
      if let reachability = note.object as? Reachability, reachability.connection == .unavailable {
        print("Network not reachable")
        groupController.reachability = false
        fieldController.reachability = false
      } else {
        groupController.reachability = true
        fieldController.reachability = true
      }
    }
    
    // MARK: - Method

    private func reloadList(_ groupId: UInt32, search : String = "") {
        tupleList.removeAll()
        
        groupController.getListGroup(groupId, search: search).forEach {
            tupleList.append((group: $0, field: nil))
        }
        fieldController.getListField(groupId, search: search).forEach {
            tupleList.append((group: nil, field: $0))
        }
        
        list.reloadData()
    }
    
    public func timeoutCallback() {
        if let viewControllers = self.navigationController?.viewControllers {
            if !viewControllers.isEmpty {
                self.navigationController?.popToViewController(viewControllers[0], animated: true)
            }
        }
        
        
    }

    // MARK: - Act
    
    @objc private func actViwMenuOpenOrClose(hideAnimation : Bool = false) {
        view.endEditing(true)
        if menuShowing, StackNavigator.share.size() == 0 {
            
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                fullPathFileXmlImport = url.appendingPathComponent(fileNameImport, isDirectory: false).path
                btnXmlImport.isEnabled = FileManager.default.fileExists(atPath: fullPathFileXmlImport)
            }
            
            btnXmlExport.isEnabled = groupController.countChild(group) > 0
            
            navigationItem.leftBarButtonItem = menuIconOpen
            cnstViewMenu.constant = 0
            viwMenu.isHidden = false
        } else {
            navigationItem.leftBarButtonItem = menuIconClose
            cnstViewMenu.constant = menuOffset
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
                self.viwMenu.isHidden = true
            }
        }
        if !hideAnimation {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
    }
    
    @IBAction private func actMenuBtnGroup(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        groupForSegue = nil
        actViwMenuOpenOrClose(hideAnimation: true)
        performSegue(withIdentifier: "group", sender: self)
    }
    
    @IBAction private func actMenuBtnField(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        fieldForSegue = nil
        actViwMenuOpenOrClose(hideAnimation: true)
        performSegue(withIdentifier: "field", sender: self)
    }
    
    @IBAction private func actBtnXmlImport(_ sender: UIButton) {
        view.endEditing(true)
        actViwMenuOpenOrClose()
        alertShow(self, title: "Warning", message: "Dou you want import data? All actual data will be deleted!", handlerNo: { _ in }) { _ in
            SwiftSpinner.show("Importing...")
            
            Timeout4Logout.shared.stop()
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                DispatchQueue.global(qos: .background).async {
                    if self.groupController.dataExport(url.appendingPathComponent(String(format: fileNameExport, dateFormatterForFile.string(from: Date())), isDirectory: false).path) {
                        if self.groupController.dataImport(self.fullPathFileXmlImport) {
                           
                            if FileManager.default.fileExists(atPath: self.fullPathFileXmlImport) {
                                do {
                                    try FileManager.default.removeItem(at: URL(fileURLWithPath: self.fullPathFileXmlImport))
                                } catch {
                                    print(error)
                                }
                            }
                            
                            if Globals.shared().sendData() {
                                DispatchQueue.main.async {
                                    SwiftSpinner.hide()
                                    self.reloadList(self.group._id)
                                    SwiftSpinner.hide()
                                    Timeout4Logout.shared.start()
                                }
                            } else {
                                DispatchQueue.main.async {
                                    SwiftSpinner.hide()
                                    alertShow(self, message: "Data not synched with server")
                                    Timeout4Logout.shared.start()
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                SwiftSpinner.hide()
                                alertShow(self, message: "Import unexpected error")
                                Timeout4Logout.shared.start()
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            SwiftSpinner.hide()
                            alertShow(self, message: "Export unexpected error")
                            Timeout4Logout.shared.start()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction private func actBtnXmlExport(_ sender: UIButton) {
        view.endEditing(true)
        
        Timeout4Logout.shared.stop()
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            SwiftSpinner.show("Exporting...")
            
            actViwMenuOpenOrClose()
            

            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            do {
                let files = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
                for file in files where file.lastPathComponent.starts(with: fileNamePrefixExport) {
                    try FileManager.default.removeItem(at: file)
                }
            } catch {
                print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
            }

            let fileUrl = url.appendingPathComponent(String(format: fileNameExport, dateFormatterForFile.string(from: Date())), isDirectory: false)
            
            DispatchQueue.global(qos: .background).async {
                if self.groupController.dataExport(fileUrl.path) {
                    DispatchQueue.main.async {
                        SwiftSpinner.hide()
                        let activityVC = UIActivityViewController(activityItems: [fileUrl], applicationActivities: nil)
    
                        Timeout4Logout.shared.start()
                        activityVC.popoverPresentationController?.sourceView = sender
                        self.present(activityVC, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        SwiftSpinner.hide()
                        alertShow(self, message: "Unexpected error")
                        Timeout4Logout.shared.start()
                    }
                }
            }
        }
    }
    
    @IBAction private func actBtnExit(_ sender: UIButton) {
        actViwMenuOpenOrClose()
        groupController.exit()
        navigationController?.popViewController(animated: true)
    }
    
}
