//
//  MedicationInfo.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/22/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import EVReflection

class AddMedicationInfo: EVObject, Codable {
    var medicationname: String!
    var medtaken_ind:Bool!
    var medicationstartdate: String!
    var medicationcategory: String!
    var medicationtype:String!
    var remindertimes:String!
    var dosage:Float!
    var dosageunit:String!
    var duration:String!
    var daysfrequency:String!
    var medium:String!
    var shape:String!
    var color:String!
    var instructions:String!
    var medicationnotes:String!
    var id:String!
    var userId:String!
    var selected:Bool? = false
    required init() {
        
    }
}

class GetMedicationInfo: EVObject, Codable {
    var results:[AddMedicationInfo]?
    required init() {
        
    }
}
