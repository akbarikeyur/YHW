//
//  HRAInfo.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 5/12/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import EVReflection

class HRAInfo: EVObject, Codable {
    var age, newhft, newhin, newhcm, newwkg: Int!
    var newwlb: Int!
    var gender, newef, newmc, newct, newmd: String!
    var dateadded, id, userId: String!
    
    required init() {
        
    }
}

