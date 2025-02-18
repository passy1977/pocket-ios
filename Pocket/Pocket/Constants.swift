//
//  Constants.swift
//  Pocket
//
//  Created by Antonio Salsi on 28/03/2020.
//  Copyright © 2020 Scapix. All rights reserved.
//

import UIKit

enum Status: Int32 {
    case REGISTERED
    case LOGIN_TRUE = 10
    case LOGIN_FALSE  = 20
    case USER_UNACTIVE
    case USER_DELETED
    case USER_ALREADY_REGISTERED
    case DEVICE_UNACTIVE
    case DEVICE_DELETED
    case DEVICE_INVALIDATED
    case ERROR = 30
    case BIOMETRIC_NOT_INIT = 40
    case BIOMETRIC_NO_BIOMETRIC_SUPPORT = 50
    case BIOMETRIC_CANCEL_BY_USER = 60
}

let primary = UIColor(named: "colorPrimary")

let synchronizatorStart = "START"
let synchronizatorEnd = "END"

let fileNameImport = "import_data.xml"
let fileNamePrefixExport = "export_data_"
let fileNameExport = "\(fileNamePrefixExport)%@.xml"
let dateFormatterForFile : DateFormatter = {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy_MM_dd_HHmmss"
    
    return dateFormatterGet
    
}()

let sessionTimeoutInSecondsDebug = 480
let sessionTimeoutInSeconds = 480


let serverHostDebug = "http://192.168.12.145:8081/api/v4"
let serverHost = "https://pocket.salsi.it/api/v4"
let serverHostUser = "user@salsi.it"
let serverHostPasswd = "5131UMpt9eAQioz6YLrl37JmEa2lyn41"
