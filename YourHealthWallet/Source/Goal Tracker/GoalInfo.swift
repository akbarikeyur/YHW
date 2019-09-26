//
//  AddCustomGoalInfo.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 7/4/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import EVReflection

class AddCustomGoalInfo: EVObject, Codable {
    var calories:Int!
    var activityname: String!
    var activityfreq: String!
    var userId:String!
    var id:String!
    required init() {
        
    }
}

class AddActivityGoalInfo: EVObject, Codable {
    var Activefor: String!
    var Activefreq: String!
    var userId:String!
    var id:String!
    var activityfreq:String!
    required init() {
        
    }
}

class AddStepsGoalInfo: EVObject, Codable {
    var Willwalk: String!
    var Addstepsfreq: String!
    var userId:String!
    var id:String!
    required init() {
        
    }
}

class AddSleepGoalInfo: EVObject, Codable {
    var Willsleep: String!
    var sleepfreq: String!
    var userId:String!
    var id:String!
    required init() {
        
    }
}

class AddRunGoalInfo: EVObject, Codable {
    var runfor: String!
    var runfreq: String!
    var userId:String!
    var id:String!
    required init() {
        
    }
}

class AddCaloriesGoalInfo: EVObject, Codable {
    var burncalories: String!
    var burnfreq: String!
    var userId:String!
    var id:String!
    required init() {
        
    }
}
