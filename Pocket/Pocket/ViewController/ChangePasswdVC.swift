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
import SwiftSpinner
import KeychainSwift

class ChangePasswdVC: UITableViewController, UITextFieldDelegate {

    @IBOutlet private weak var txtOldPasswd: UITextField!
    @IBOutlet private weak var txtPasswd: UITextField!
    @IBOutlet private weak var txtPasswdConfirm: UITextField!
    
    private let groupController = GroupController()
    
    private let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timeout4Logout.shared.updateTimeLeft()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Act
    
    @IBAction func actBtnAdd(_ sender: UIBarButtonItem) {
        guard let oldPasswd = txtOldPasswd.text, let newPasswd = txtPasswd.text, let confirmPasswd = txtPasswdConfirm.text else {
            return;
        }
        
        if oldPasswd != Globals.shared().user.passwd {
            alertShow(self, message: "Wrong old passwd")
            return
        }
        
        if newPasswd.isEmpty || confirmPasswd.isEmpty {
            alertShow(self, message: "New password or confirm password are empty")
            return
        }
        
        if newPasswd != confirmPasswd {
            alertShow(self, message: "New password and confirm password not match")
            return
        }
        
        guard var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            alertShow(self, message: "New password and confirm password not match")
            return
        }
        url = url.appendingPathComponent(fileNameChangePasswd);
        
        alertShow(self, title: "Warning", message: "Dou you want change passwd?", handlerNo: { _ in }) { _ in
            Timeout4Logout.shared.stop()
            
            SwiftSpinner.show("Changing passwd...")
            
            DispatchQueue.global(qos: .background).async {
                Globals.shared().changePasswd(url.path, newPasswd: newPasswd)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    SwiftSpinner.hide()
                    self.keychain.set(KEY_PASSWD, forKey: newPasswd)
                    Globals.shared().logout(true)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        
    }
}
