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
