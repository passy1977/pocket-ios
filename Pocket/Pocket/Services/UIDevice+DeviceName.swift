////
////  Utsname.swift
////  Pocket
////
////  Created by Antonio Salsi on 03/05/2020.
////  Copyright © 2020 Scapix. All rights reserved.
////
//
//
//public extension UIDevice {
//
//    static let deviceNamesByCode : [String: String] =
//            ["i386"      : "Simulator",
//             "x86_64"    : "Simulator",
//             "iPod1,1"   : "iPod Touch",        // (Original)
//                "iPod2,1"   : "iPod Touch",        // (Second Generation)
//                "iPod3,1"   : "iPod Touch",        // (Third Generation)
//                "iPod4,1"   : "iPod Touch",        // (Fourth Generation)
//                "iPod7,1"   : "iPod Touch",        // (6th Generation)
//                "iPod9,1" : "7th Gen iPod",
//    
//    
//                "iPhone1,1" : "iPhone",            // (Original)
//                "iPhone1,2" : "iPhone",            // (3G)
//                "iPhone2,1" : "iPhone",            // (3GS)
//                "iPhone3,1" : "iPhone 4",          // (GSM)
//                "iPhone3,3" : "iPhone 4",          // (CDMA/Verizon/Sprint)
//                "iPhone4,1" : "iPhone 4S",         //
//                "iPhone5,1" : "iPhone 5",          // (model A1428, AT&T/Canada)
//                "iPhone5,2" : "iPhone 5",          // (model A1429, everything else)
//                "iPhone5,3" : "iPhone 5c",         // (model A1456, A1532 | GSM)
//                "iPhone5,4" : "iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
//                "iPhone6,1" : "iPhone 5s",         // (model A1433, A1533 | GSM)
//                "iPhone6,2" : "iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
//                "iPhone7,1" : "iPhone 6 Plus",     //
//                "iPhone7,2" : "iPhone 6",          //
//                "iPhone8,1" : "iPhone 6S",         //
//                "iPhone8,2" : "iPhone 6S Plus",    //
//                "iPhone8,4" : "iPhone SE",         //
//                "iPhone9,1" : "iPhone 7",          //
//                "iPhone9,3" : "iPhone 7",          //
//                "iPhone9,2" : "iPhone 7 Plus",     //
//                "iPhone9,4" : "iPhone 7 Plus",     //
//                "iPhone10,1": "iPhone 8",          // CDMA
//                "iPhone10,4": "iPhone 8",          // GSM
//                "iPhone10,2": "iPhone 8 Plus",     // CDMA
//                "iPhone10,5": "iPhone 8 Plus",     // GSM
//                "iPhone10,3": "iPhone X",          // CDMA
//                "iPhone10,6": "iPhone X",          // GSM
//                "iPhone11,2": "iPhone XS",         //
//                "iPhone11,4": "iPhone XS Max",     //
//                "iPhone11,6": "iPhone XS Max",     // China
//                "iPhone11,8": "iPhone XR",         //
//                "iPhone12,1" : "iPhone 11",
//                "iPhone12,3" : "iPhone 11 Pro",
//                "iPhone12,5" : "iPhone 11 Pro Max",
//    
//                "iPad1,1"   : "iPad",              // (Original)
//                "iPad2,1"   : "iPad 2",            //
//                "iPad3,1"   : "iPad",              // (3rd Generation)
//                "iPad3,4"   : "iPad",              // (4th Generation)
//                "iPad2,5"   : "iPad Mini",         // (Original)
//                "iPad4,1"   : "iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
//                "iPad4,2"   : "iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
//                "iPad4,4"   : "iPad Mini",         // (2nd Generation iPad Mini - Wifi)
//                "iPad4,5"   : "iPad Mini",         // (2nd Generation iPad Mini - Cellular)
//                "iPad4,7"   : "iPad Mini",         // (3rd Generation iPad Mini - Wifi (model A1599))
//                "iPad6,7"   : "iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
//                "iPad6,8"   : "iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
//                "iPad6,3"   : "iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
//                "iPad6,4"   : "iPad Pro (9.7\")",   // iPad Pro 9.7 inches - (models A1674 and A1675)
//                "iPad7,11" : "iPad 7th Gen 10.2-inch (WiFi)",
//                "iPad7,12" : "iPad 7th Gen 10.2-inch (WiFi+Cellular)",
//                "iPad8,1": "iPad Pro 11 inch (WiFi)",
//                "iPad8,2": "iPad Pro 11 inch (1TB, WiFi)",
//                "iPad8,3": "iPad Pro 11 inch (WiFi+Cellular)",
//                "iPad8,4": "iPad Pro 11 inch (1TB, WiFi+Cellular)",
//                "iPad8,5": "iPad Pro 12.9 inch 3rd Gen (WiFi)",
//                "iPad8,6": "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi)",
//                "iPad8,7": "iPad Pro 12.9 inch 3rd Gen (WiFi+Cellular)",
//                "iPad8,8": "iPad Pro 12.9 inch 3rd Gen (1TB, WiFi+Cellular)",
//                "iPad8,9": "iPad Pro 11 inch 2nd Gen (WiFi)",
//                "iPad8,10": "iPad Pro 11 inch 2nd Gen (WiFi+Cellular)",
//                "iPad8,11": "iPad Pro 12.9 inch 4th Gen (WiFi)",
//                "iPad8,12": "iPad Pro 12.9 inch 4th Gen (WiFi+Cellular)",
//                "iPad11,1" : "iPad mini 5th Gen (WiFi)",
//                "iPad11,2" : "iPad mini 5th Gen",
//                "iPad11,3" : "iPad Air 3rd Gen (WiFi)",
//                "iPad11,4 ": "iPad Air 3rd Gen",
//    
//                "Watch1,1" : "Apple Watch 38mm case",
//                "Watch1,2" : "Apple Watch 38mm case",
//                "Watch5,4" : "Apple Watch Series 5 (44mm, LTE)",
//                "Watch5,3" : "Apple Watch Series 5 (40mm, LTE)",
//                "Watch5,2" : "Apple Watch Series 5 (44mm)",
//                "Watch5,1" : "Apple Watch Series 5 (40mm)",
//    
//                "AppleTV1,1": "Apple TV (1st Gen)",
//                "AppleTV2,1": "Apple TV (2nd Gen)",
//                "AppleTV3,1": "Apple TV (3rd Gen)",
//                "AppleTV3,2": "Apple TV (3rd Gen)",
//                "AppleTV5,3": "Apple TV HD (4th Gen)",
//                "AppleTV6,2": "Apple TV 4K"
//        ]
//    
//    static let modelName: String = {
//        var systemInfo = utsname()
//        uname(&systemInfo)
//        let machineMirror = Mirror(reflecting: systemInfo.machine)
//        let identifier = machineMirror.children.reduce("") { identifier, element in
//            guard let value = element.value as? Int8, value != 0 else { return identifier }
//            return identifier + String(UnicodeScalar(UInt8(value)))
//        }
//
//        
//        return deviceNamesByCode[identifier] ?? "unknow"
//    }()
//    
//    static let modelNameAndOSVersion: String = {
//        return "\(modelName) \(UIDevice.current.systemVersion)"
//    }()
//
//}
