//
//  GlobalVars.swift
//  YourHealthWallet
//
//  Created by PC on 3/28/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit



class GlobalVars: NSObject {
    static var latitude:Float = 0
    static  var longitude:Float = 0
}

struct REMINDER {
    struct REPEAT {
        static let NOT_REPEAT = "Do not repeat"
        static let EVERYDAY = "Everyday"
        static let DAYS_INTERVAL = "Days Interval"
        static let EVERY_WEEK = "Every week"
        static let DAYS_WEEK = "Specific days of week"
        static let EVERY_MONTH = "Every month"
        static let EVERY_YEAR = "Every year"
        
        static let TWO_DAYS_INTERVAL = "Every 2 days"
        static let THREE_DAYS_INTERVAL = "Every 3 days"
        static let FOUR_DAYS_INTERVAL = "Every 4 days"
        static let FIVE_DAYS_INTERVAL = "Every 5 days"
    }
}
