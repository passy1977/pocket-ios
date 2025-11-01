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
        
#if DEBUG
        if let passwd = Bundle.main.object(forInfoDictionaryKey: "FAST_LOGIN_PASSWD") as? String, !passwd.isEmpty {
            txtPasswd.text = passwd
            txtPasswdConfirm.text = passwd
        }
#endif
        
        txtViewDeviceJson.text = """
            {"id":2,"uuid":"8aac9e00-7d63-4758-bedd-50d22ecb3971","status":"ACTIVE","timestampLastUpdate":1761956043,"timestampCreation":1761956043,"userId":2,"host":"https://test.api-pocket.salsi.it","hostPublicKey":"-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu0/NI63LfihCBlt0E1600G/eH2T8sWjc/1tBcE0c9v9/fe8O0959ZGa4UJ02FVj3oNbx8vIDlF5RiKR20UeLO8V7GnupIxEbT+PKnOOhI8j/iLBUmInCR8ropsU1iWjbnM35Y5mE8oK6b92qT6aHTi027SooHh7DzmCMAQLBdN/pbdURTk5YwRUgS6um1iy2x0/APiWLTz4YWWFawdegTC5mV73VRiMA+a2RrN9IkXbbqCibo2o4OI4R3q5mC693jUtBRUCP/+nroWZDUZzYnRCWt5pl1bQxGXdkNvSr2GPLrYwZGo+cZMsvUnm15g7V6+f81aH2zoM8DEFbwSDWXwIDAQAB\n-----END PUBLIC KEY-----\n","aesCbcIv":"Wc1Rb2irikLB8HsM","corsEnableStrict":false,"corsHeaderToken":"bsr9yvsq63c9s6Mx"}
            """
        
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
        
        if !Pocket.shared().initialize(url.absoluteString, configJson: txtViewDeviceJson.text, passwd: passwd) {
            txtViewDeviceJson.text.removeAll()
            alertShow(self, message: "Server Data wrong format")
            return
        }
        
        loginVCValue?.passwd = self.txtPasswd.text
        navigationController?.popViewController(animated: true)
    }
    
}
