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
import SwiftSpinner

final class LoginVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var txtHost: UITextField!
    @IBOutlet private weak var cnstTxtHost: NSLayoutConstraint!
    @IBOutlet private weak var txtHostUser: UITextField!
    @IBOutlet private weak var txtHostPasswd: UITextField!
    @IBOutlet private weak var txtEmail: UITextField!
    @IBOutlet private(set) public weak var txtPasswd: UITextField! //lasciarlo pubblico
    @IBOutlet private weak var btnLogin: UIButton!
    @IBOutlet private weak var btnAddNewUser: UIButton!
    
    //MARK: - Data
    private let controller = LoginController()
    private let controllerGroup = GroupController()
    
    private let cnstTxtHostShow : CGFloat = 92
    private let cnstTxtHostHide : CGFloat = 8
    
    //MARK: - system
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let user = Globals.getInstance().getSafeUser()
        Timeout4Logout.getShared(user: user).stop()
        
        StackNavigator.getInstance().clear()
        
        if !user.isEmpty() {
            do {
                guard let UUDID = UIDevice.current.identifierForVendor?.uuidString else {
                    throw NSError(domain: "LoginVC", code: 1)
                }
                Globals.getInstance().initSystemCrypto(UUDID)
            } catch {
                print(error)
                return;
            }
            
            setForm(user: user)
            controller.loginBiometric {passwd in
                LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Place your finger on the sensor") {success, _ in
                    if (success) {
                        do {
                            try self.performLogin(host: user.getHost(),
                                                  hostAuthUser: user.getHostAuthUser(),
                                                  hostAuthPasswd: user.getHostAuthPasswd(),
                                                  email: user.getEmail(),
                                                  passwd: passwd)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        } else {
            setForm(user: nil)
#if ENABLE_SERVER_DEBUG
            txtHost.text = serverHostDebug
#else
            txtHost.text = serverHost
#endif
            txtHostUser.text = serverHostUser
            txtHostPasswd.text = serverHostPasswd
        }
#if ENABLE_SERVER_DEBUG
        txtEmail.text = "passy.linux@zresa.it"
        txtPasswd.text = "md3d4mp3rX_"
#endif

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
            try self.performLogin(host: self.txtHost.text ?? "",
                                  hostAuthUser: self.txtHostUser.text ?? "",
                                  hostAuthPasswd: self.txtHostPasswd.text ?? "",
                                  email: self.txtEmail.text ?? "",
                                  passwd: self.txtPasswd.text ?? "")
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - Functions
    
    private func setForm(user u: User?) {
        if let user = u {
            btnAddNewUser.isEnabled = false
            txtHostUser.isHidden = true
            txtHostPasswd.isHidden = true
            txtHost.isEnabled = false
            cnstTxtHost.constant = cnstTxtHostHide
            txtHost.text = user.getHost()
            txtHostUser.text = user.getHostAuthUser()
            txtHostPasswd.text = user.getHostAuthPasswd()
            txtEmail.text = user.getEmail()
        } else {
            btnAddNewUser.isEnabled = true
            cnstTxtHost.constant = cnstTxtHostShow
            txtHostUser.isHidden = false
            txtHostPasswd.isHidden = false
            txtHost.text = ""
            txtHostUser.text = ""
            txtHostPasswd.text = ""
            txtEmail.text = ""
            txtPasswd.text = ""
        }
    }
    
    @inline(__always)
    private func checkLogin() {
        btnLogin.isEnabled = !(txtHost.text?.isEmpty ?? false) && !(txtEmail.text?.isEmpty ?? false) && !(txtPasswd.text?.isEmpty ?? false) 
    }
    
    
    private func performLogin(host: String, hostAuthUser: String, hostAuthPasswd: String, email: String, passwd: String) throws {
        if email.isEmpty || passwd.isEmpty {
            alertShow(self, message: "Wrong credential")
        }
        
        guard let UUDID = UIDevice.current.identifierForVendor?.uuidString else {
            throw NSError(domain: "LoginVC", code: 1)
        }

        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                SwiftSpinner.show("Synchronize to server...")
            }
        }
        
        let semaphore = DispatchSemaphore(value: 1)
        controller.login(SystemInfo().modelNameAndOSVersion
                         , deviceSerial: UUDID
                         , host: host
                         , hostAuthUser: hostAuthUser
                         , hostAuthPasswd: hostAuthPasswd
                         , email: email
                         , passwd: passwd
        ) { status in
            DispatchQueue.main.async {
                SwiftSpinner.hide()
                
                semaphore.signal()
                if status == Status.USER_UNACTIVE.rawValue {
                    alertShow(self, message: "User unactive")
                    self.txtPasswd.text = ""
                } else if status == Status.USER_DELETED.rawValue {
                    alertShow(self, message: "User deleted, all data will be deleted")
                    self.controllerGroup.exit()
                    self.setForm(user: nil)
                } else if status == Status.DEVICE_DELETED.rawValue {
                    alertShow(self, message: "Device deleted, all data will be deleted")
                    self.controllerGroup.exit()
                    self.setForm(user: nil)
                } else if status == Status.DEVICE_INVALIDATED.rawValue {
                    alertShow(self, message: "Device invalidated, try to perform login again")
                    self.controllerGroup.exit()
                } else if status == Status.DEVICE_UNACTIVE.rawValue {
                    alertShow(self, message: "Device unactive")
                    self.txtPasswd.text = ""
                } else if status == Status.LOGIN_TRUE.rawValue {
                    
                    Timeout4Logout.getShared(user: Globals.getInstance().getSafeUser()).start()
                    
                    self.performSegue(withIdentifier: "groups", sender: self)
                } else {
                    alertShow(self, message: "Wrong credential")
                    self.txtPasswd.text = ""
                }
            }
        }
        semaphore.wait()
    }
    
}

