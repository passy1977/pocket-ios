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

final class AddNewUserVC: UITableViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var txtPasswd: UITextField!
    @IBOutlet private weak var txtPasswdConfirm: UITextField!
    @IBOutlet private weak var txtViewDeviceJson: UITextView!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet var list: UITableView!
    
    
    //MARK: - Data
    
    private weak var loginVCValue : LoginVC? = nil
    public weak var loginVC : LoginVC? {
        @available(*, unavailable)
        get {
            fatalError("You cannot read from this object.")
        }
        set {
            loginVCValue = newValue
        }
    }
    
    //MARK: - system
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Act
    
    @IBAction private func actBtnSave(_ sender: UIBarButtonItem) {
        if txtViewDeviceJson.text.isEmpty {
            alertShow(self, message: "Server Data is mnandatory")
            return
        }
        
        guard let passwd = txtPasswd.text else {
            alertShow(self, message: "Password is mnandatory")
            return
        }
        
        guard let passwdConfirm = txtPasswdConfirm.text else {
            alertShow(self, message: "Password confirm is mnandatory")
            return
        }
        
        if passwd != passwdConfirm || passwd.isEmpty || passwdConfirm.isEmpty {
            txtPasswd.text?.removeAll()
            txtPasswdConfirm.text?.removeAll()
            alertShow(self, message: "Password and Password confirm dont match or empty")
            return
        }
        
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        if !Globals.shared().initialize(url.absoluteString, configJson: txtViewDeviceJson.text, passwd: passwd) {
            txtViewDeviceJson.text.removeAll()
            alertShow(self, message: "Server Data wrong format")
            return
        }
        
        loginVCValue?.passwd = self.txtPasswd.text
        navigationController?.popViewController(animated: true)
    }
    
}
