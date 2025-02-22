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

@discardableResult
func alertShow(_ controller : UIViewController, title: String = "Warning", message: String, handlerNo: ((UIAlertAction) -> Void)? = nil, handlerYes: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    
    if handlerNo == nil, handlerYes == nil {
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
    } else {
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: handlerYes))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: handlerNo))
    }

    controller.present(alert, animated: true)
    return alert
}



func spinnerStatusShow(_ controller : UIViewController, status : String, callback cbck: ((String) -> ())? = nil) {
    switch status {
    case synchronizatorStart:
        SwiftSpinner.show("Synchronize to server...")
        if let callback = cbck {
            callback(status)
        }
    case synchronizatorEnd:
        SwiftSpinner.hide()
        if let callback = cbck {
            callback(status)
        }
    default:
        SwiftSpinner.hide()
        alertShow(controller, title: "Error", message: status)
        if let callback = cbck {
            callback(status)
        }
    }
}
