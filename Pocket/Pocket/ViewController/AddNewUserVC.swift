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
    @IBOutlet private weak var txtHost: UITextField!
    @IBOutlet private weak var txtHostUser: UITextField!
    @IBOutlet private weak var txtHostPasswd: UITextField!
    @IBOutlet private weak var txtName: UITextField!
    @IBOutlet private weak var txtEmail: UITextField!
    @IBOutlet private weak var txtPasswd: UITextField!
    @IBOutlet private weak var txtPasswdConfirm: UITextField!
    
    //MARK: - Data
    private var txtHostCheck = false
    private var txtHostUserCheck = false
    private var txtHostPasswdCheck = false
    private var txtNameCheck = false
    private var txtEmailCheck = false
    private var txtPasswdCheck = false
    private var txtPasswdConfirmCheck = false
    
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet var list: UITableView!
    
    private let fieldNotEmpty = "Filed is mandatory"
    
    private let controller = LoginController()
    
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
        btnSave.isEnabled = false
        #if ENABLE_SERVER_DEBUG
        txtHost.text = serverHostDebug
        #else
        txtHost.text = serverHost
        #endif
        txtHostUser.text = serverHostUser
        txtHostPasswd.text = serverHostPasswd
        txtHostCheck = true
        txtHostUserCheck = true
        txtHostPasswdCheck = true        
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Act
    
    @IBAction private func actBtnSave(_ sender: UIBarButtonItem) {
        
        if let host = txtHost.text {
            if !host.starts(with: "http://") && !host.starts(with: "https://") {
                txtHost.text = "http://" + txtHost.text!
            }
        }
    
        let user = User()
        user.setHost(txtHost.text ?? "")
        user.setHostAuth(txtHostUser.text ?? "")
        user.setHostAuthPasswd(txtHostPasswd.text ?? "")
        user.setName(txtName.text ?? "")
        user.setEmail(txtEmail.text ?? "")
        user.setPasswd(txtPasswd.text ?? "")
        
        let ret = controller.insert(user)
        if ret == Status.REGISTERED.rawValue {
            //Globals.getInstance().setUser(user)
            
            loginVCValue?.txtPasswd.text = user.getPasswd()
            
            self.navigationController?.popViewController(animated: true)
        } else if ret == Status.LOGIN_FALSE.rawValue {
            alertShow(self, message: "Wrong server credential")
        } else if ret == Status.USER_ALREADY_REGISTERED.rawValue {
            alertShow(self, message: "User already registered")
        } else {
            alertShow(self, message: "No server connection")
        }
        
    }
    
    
    
    @IBAction private func actTxtFieldChange(_ sender: UITextField) {
        switch sender {
        case txtHost:
            txtHostCheck = !(txtHost?.text?.isEmpty ?? false)
            if !txtHostCheck {
                sender.setBottomBorderOnlyWith()
            } else {
                sender.unsetBottomBorderOnlyWith()
            }
        case txtHostUser:
            txtHostUserCheck = !(txtHostUser?.text?.isEmpty ?? false)
            if !txtHostUserCheck {
                sender.setBottomBorderOnlyWith()
            } else {
                sender.unsetBottomBorderOnlyWith()
            }
        case txtHostPasswd:
            txtHostPasswdCheck = !(txtHostPasswd?.text?.isEmpty ?? false)
            if !txtHostPasswdCheck {
                sender.setBottomBorderOnlyWith()
            } else {
                sender.unsetBottomBorderOnlyWith()
            }
        case txtName:
            txtNameCheck = !(txtName?.text?.isEmpty ?? false)
            if !txtNameCheck {
                sender.setBottomBorderOnlyWith()
            } else {
                sender.unsetBottomBorderOnlyWith()
            }
        case txtEmail:
            txtEmailCheck = !(txtEmail?.text?.isEmpty ?? false)
            if !txtEmailCheck {
                sender.setBottomBorderOnlyWith()
            } else if (!isEmailValid(txtEmail.text ?? "")) {
                sender.setBottomBorderOnlyWith()
            } else {
                sender.unsetBottomBorderOnlyWith()
            }
        case txtPasswd:
            txtPasswdCheck = !(txtPasswd?.text?.isEmpty ?? false)
            if !txtPasswdCheck {
                sender.setBottomBorderOnlyWith()
            } else if txtPasswd.text != txtPasswdConfirm.text {
                sender.setBottomBorderOnlyWith()
                txtPasswdConfirm.setBottomBorderOnlyWith()
            } else {
                sender.unsetBottomBorderOnlyWith()
                txtPasswdConfirm.unsetBottomBorderOnlyWith()
            }
        case txtPasswdConfirm:
            txtPasswdConfirmCheck = !(txtPasswdConfirm?.text?.isEmpty ?? false)
            if !txtPasswdConfirmCheck {
                sender.setBottomBorderOnlyWith()
            } else if txtPasswd.text != txtPasswdConfirm.text {
                sender.setBottomBorderOnlyWith()
                txtPasswd.setBottomBorderOnlyWith()
            } else {
                sender.unsetBottomBorderOnlyWith()
                txtPasswd.unsetBottomBorderOnlyWith()
            }
        default:
            print("boo")
        }
        
        btnSave.isEnabled = txtHostCheck && txtHostUserCheck && txtHostPasswdCheck && txtNameCheck && txtEmailCheck && txtPasswdConfirmCheck && txtPasswdConfirmCheck
    }
    
    // MARK: - Functions
    
    private func isEmailValid(_ value: String) -> Bool {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                return false
            }
        } catch {
            return false
        }
        return true
    }
    
}
