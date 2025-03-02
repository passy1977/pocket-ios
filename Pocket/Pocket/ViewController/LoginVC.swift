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
import LocalAuthentication
import KeychainSwift
import SwiftSpinner

final class LoginVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var txtEmail: UITextField!
    @IBOutlet private(set) public weak var txtPasswd: UITextField! //lasciarlo pubblico
    @IBOutlet private weak var btnLogin: UIButton!
    @IBOutlet private weak var btnAddNewUser: UIButton!
    
    //MARK: - Data
    private let cnstTxtHostShow : CGFloat = 92
    private let cnstTxtHostHide : CGFloat = 8
    
    private var configJson : String? = nil
    public var passwd : String? = nil
    
    private let keychain = KeychainSwift()
    
    //MARK: - system
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //let user = Globals.getInstance().getSafeUser()
        //Timeout4Logout.getShared(user: user).stop()
    
        if let configJson = UserDefaults.standard.string(forKey: KEY_DEVICE) {
            self.configJson = configJson
            
            StackNavigator.share.clear()
            
            if let email = keychain.get(KEY_EMAIL) {
                if let passwd = self.passwd {
                    setForm(email, passwd: passwd)
                } else {
                    passwd = keychain.get(KEY_PASSWD)
                    setForm(email)
                }

                authenticateUser() { [self] completion in
                    if(completion) {
                        do {
                            try self.performLogin(email: email,
                                                  passwd: passwd)
                        } catch {
                            print(error)
                        }
                    }
                }
            }

        } else {
            setForm(nil)
            performSegue(withIdentifier: "newUser", sender: self)
            
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newUser" {
            if let addNewUserVC = segue.destination as? AddNewUserVC {
                addNewUserVC.loginVC = self
            }
        }
    }
    
    // MARK: - Act
    
    @IBAction private func cngTxetField(_ sender: Any) {
        checkLogin()
    }
    
    @IBAction private func actBtnLogin(_ sender: UIButton) {
        do {
            try self.performLogin(email: self.txtEmail.text,
                                  passwd: self.txtPasswd.text)
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - Functions
    
    private func setForm(_ email : String?, passwd: String? = nil) {
        if let email = email {
            btnAddNewUser.isEnabled = false
            txtEmail.text = email
        } else {
            btnAddNewUser.isEnabled = true
            txtEmail.text = ""
        }
        
        if let passwd = passwd {
            txtPasswd.text = passwd
        } else {
            txtPasswd.text = ""
        }
        
        btnAddNewUser.isEnabled = configJson == nil
    }
    
    @inline(__always)
    private func checkLogin() {
        btnLogin.isEnabled = !(txtEmail.text?.isEmpty ?? false) && !(txtPasswd.text?.isEmpty ?? false) 
    }
    
    
    private func performLogin(email: String?, passwd: String?) throws {
        guard let email = email else { return }
        guard let passwd = passwd else { return }
        guard let _ = UserDefaults.standard.string(forKey: KEY_DEVICE) else {
            performSegue(withIdentifier: "newUser", sender: self)
            return
        }
        
        if email.isEmpty || passwd.isEmpty {
            alertShow(self, message: "Credentials are mandatory")
        }
    
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                SwiftSpinner.show("Synchronize to server...")
            }
        }
        
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            SwiftSpinner.hide()
            return
        }
        
        if !Globals.getInstance().initialize(url.absoluteString, configJson: nil, passwd: passwd) {
            txtPasswd.text = ""
            alertShow(self, message: "Server Data wrong format")
            SwiftSpinner.hide()
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            let rc = Globals.getInstance().login(email, passwd: passwd)
            DispatchQueue.main.async {
                SwiftSpinner.hide()
            }
            if(rc == .OK)
            {
                let user = Globals.getInstance().getUser()
                
                if(user?.getStatus() ?? .NOT_ACTIVE == .ACTIVE)
                {
                    //Timeout4Logout.getShared(user: Globals.getInstance().getSafeUser()).start()
                    
                    self.keychain.set(email, forKey: KEY_EMAIL)
                    self.keychain.set(passwd, forKey: KEY_PASSWD)
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "groups", sender: self)
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        alertShow(self, message: "User unactive")
                        self.txtPasswd.text = ""
                    }
                }
            }
            else if(rc == .SECRET_NOT_MATCH)
            {
                DispatchQueue.main.async {
                    alertShow(self, message: "Server secret code issue")
                    self.txtPasswd.text = ""
                }
            }
        }

    }
    
    
    fileprivate func authenticateUser(completion: @escaping (Bool) -> () = { _ in }) {
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Authenticate you to access your app by Touch ID or Face ID",
                                   reply: { success, error in
                if success {
                    
                    completion(true)
                    
                } else {
                    
                    completion(false)
                    
                    if let error = error {
                        print("Errore di autenticazione: \(error.localizedDescription)")
                    }
                }
            })
        } else {
            print("Device don't support Touch ID or Face ID");
            completion(false)
            
            print("Il dispositivo non supporta la funzionalità di autenticazione biometrica.")
        }
    }

}

