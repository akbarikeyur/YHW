//
//  AddHeartRateInfo.swift
//  YourHealthWallet
//
//  Created by Keyur on 05/09/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Foundation
import EVReflection

class AddHeartRateInfo: EVObject, Codable {

    var id : String!
    var userId: String!
    var hrdate: String!
    var heartrate : String!
//    var hrimages : [String]!
    
    required init() {
        
    }
}

class GetHeartRateInfo: EVObject, Codable {
    var results:[AddHeartRateInfo]?
    required init() {
        
    }
}
