//
//  TextFieldExtension.swift
//  Pocket
//
//  Created by Antonio Salsi on 28/03/2020.
//  Copyright © 2020 Scapix. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setBottomBorderOnlyWith(color: UIColor) {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
        self.borderStyle = .none
        self.layer.borderWidth = 0.75
        self.layer.borderColor = color.cgColor
    }
    func setBottomBorderOnlyWith() {
        guard let p = primary else {
            return
        }
        setBottomBorderOnlyWith(color: p)
    }
    
    func unsetBottomBorderOnlyWith() {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
        self.borderStyle = .none
        self.layer.borderWidth = 0.75
        self.layer.borderColor = UIColor.systemGray3.cgColor
    }
}
