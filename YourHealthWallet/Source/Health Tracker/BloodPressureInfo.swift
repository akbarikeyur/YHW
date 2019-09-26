//
//  BloodPressureInfo.swift
//  YourHealthWallet
//
//  Created by Keyur on 29/08/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import EVReflection

class AddBloodPressureInfo: EVObject, Codable {
    var bpdate: String!
    var systolic:String!
    var diastolic: String!
    var pulserate: String!
    var medicationname:String!
    var id:String!
    var userId:String!
//    var bpimages : [String]!
    required init() {
        
    }
}

class GetBloodPressureInfo: EVObject, Codable {
    var results:[AddBloodPressureInfo]?
    required init() {
        
    }
}
