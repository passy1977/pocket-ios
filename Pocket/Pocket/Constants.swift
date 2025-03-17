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

let primary = UIColor(named: "colorPrimary")

let synchronizatorStart = "START"
let synchronizatorEnd = "END"

let fileNameImport = "import_data.json"
let fileNamePrefixExport = "export_data_"
let fileNameExport = "\(fileNamePrefixExport)%@.json"
let dateFormatterForFile : DateFormatter = {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy_MM_dd_HHmmss"
    
    return dateFormatterGet
    
}()

#if DEBUG
let sessionTimeoutInSeconds = 480
#else
let sessionTimeoutInSeconds = 480
#endif
