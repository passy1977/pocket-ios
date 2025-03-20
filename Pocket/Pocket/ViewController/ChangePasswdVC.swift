//
//  ChangePasswdVC.swift
//  Pocket
//
//  Created by Antonio Salsi on 20/03/25.
//  Copyright © 2025 Scapix. All rights reserved.
//

import UIKit

class ChangePasswdVC: UITableViewController, UITextFieldDelegate {

    @IBOutlet private weak var txtOldPasswd: UITextField!
    @IBOutlet private weak var txtPasswd: UITextField!
    @IBOutlet private weak var txtPasswdConfirm: UITextField!
    
    private let groupController = GroupController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtOldPasswd.text = "ciao"
        txtPasswd.text = "ciao1"
        txtPasswdConfirm.text = "ciao2"
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // MARK: - Act
    
    @IBAction func actBtnAdd(_ sender: UIBarButtonItem) {
        
    }
}
