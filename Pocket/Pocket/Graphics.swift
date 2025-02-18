//
//  Graphics.swift
//  Pocket
//
//  Created by Antonio Salsi on 29/03/2020.
//  Copyright © 2020 Scapix. All rights reserved.
//

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
