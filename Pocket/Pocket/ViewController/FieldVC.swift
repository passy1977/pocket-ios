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

final class FieldVC: UIViewController, UITextFieldDelegate {

    //MARK: - IBOutlet
    @IBOutlet private weak var txtTitle: UITextField!
    @IBOutlet private weak var txtValue: UITextField!
    @IBOutlet private weak var switchIsHidden: UISwitch!
    @IBOutlet private weak var btnAdd: UIBarButtonItem!
    @IBOutlet private weak var btnGenerateRandomValue: UIButton!
    
    //MARK: - Data
    private let reachability = try! Reachability()
    public weak var fieldController : FieldController? = nil
    public var group = Group()

    public weak var field : Field? = nil

    //MARK: - system
    override func viewDidLoad() {   
        super.viewDidLoad()
        
        fieldController?.initialize()
        
        if let field = self.field {
            setField(enable: true, title: field.getTitle(), value: field.getValue(), isHidden: field.getIsHidden())
        } else {
            setField(enable: false)
        }
        
        if let group = StackNavigator.share.peek?.0 {
            self.group = group
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
          try reachability.startNotifier()
        }catch{
          print("could not start reachability notifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        Timeout4Logout.getShared().updateTimeLeft()
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
        fieldController?.reachability = false
      } else {
        fieldController?.reachability = true
      }
    }
    
    // MARK: - Act

    

    @IBAction private func actBtnAdd(_ sender: UIBarButtonItem) {
            
        let semaphore = DispatchSemaphore(value: 1)
        if self.field == nil {
            let field = Field()
            field.setGroupId(group.getid())
            field.setTitle(txtTitle.text ?? "")
            field.setValue(txtValue.text ?? "")
            field.setIsHidden(switchIsHidden.isOn)
            GroupsFieldsVC.overrideSearch = field.getTitle()
            fieldController?.insert(field) { status in
                DispatchQueue.main.async {
                    spinnerStatusShow(self, status: status)
                }
                if status == synchronizatorStart {
                    semaphore.wait()
                } else if status == synchronizatorEnd {
//                    Timeout4Logout.getShared().start()
                    semaphore.signal()
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            if let field = self.field {
                field.setTitle(txtTitle.text ?? "")
                field.setValue(txtValue.text ?? "")
                field.setIsHidden(switchIsHidden.isOn)
                GroupsFieldsVC.overrideSearch = field.getTitle()
                fieldController?.update(field) { status in
                    DispatchQueue.main.async {
                        spinnerStatusShow(self, status: status)
                    }
                    if status == synchronizatorStart {
                        semaphore.wait()
                    } else if status == synchronizatorEnd {
                        GroupsFieldsVC.overrideSearch = field.getTitle()
//                        Timeout4Logout.getShared().start()
                        semaphore.signal()
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction private func actTxtFieldChange(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        if text.isEmpty {
            sender.setBottomBorderOnlyWith()
        } else {
            sender.unsetBottomBorderOnlyWith()
        }
        if sender == txtTitle {
            txtValue.isEnabled = !text.isEmpty
            btnAdd.isEnabled = !text.isEmpty
            switchIsHidden.isEnabled = !text.isEmpty
        }
    }
    
    @inlinable
    @IBAction func actBtnGenerateRandomValue(_ sender: UIButton) {
        switchIsHidden.isOn = true
        txtValue.text = PasswordGenerator.shared.generatePassword(includeNumbers: true, includePunctuation: true, includeSymbols: true, length: 16)
    }
    
    // MARK: - Function
    
    private func setField(enable: Bool, title: String = "", value: String = "", isHidden : Bool? = nil) {
        txtTitle.text = title
        txtValue.text = value
        switchIsHidden.isOn = isHidden ?? false
        txtValue.isEnabled = enable
        btnAdd.isEnabled = enable
        switchIsHidden.isEnabled = enable
        
    }
    
}
