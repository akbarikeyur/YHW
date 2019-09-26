//
//  ReminderInfo.swift
//  YourHealthWallet
//
//  Created by Shridhar on 13/02/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import Foundation
import EVReflection


class ReminderInfo: EVObject {
    
    var time: String!
    var image: UIImage!
    var title: String!
    var color = ColorType.Clear
}

class AddReminderInfo: EVObject, Codable {
    
    var id: String!
    var reminderstartdate: String!
    var remindertype: String!
    var repeatinterval: String!
    var userId: String!
    
    required init() {
        
    }
}

class GetReminderInfo: EVObject, Codable {
    var data:[AddReminderInfo]?
    required init() {
        
    }
}
