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


let serverHostDebug = ""
let serverHost = ""
let serverHostUser = ""
let serverHostPasswd = ""
