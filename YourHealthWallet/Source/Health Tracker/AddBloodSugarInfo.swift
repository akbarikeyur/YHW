//
//  AddBloodSugarInfo.swift
//  YourHealthWallet
//
//  Created by Keyur on 06/09/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Foundation
import EVReflection

class AddBloodSugarInfo: EVObject, Codable {

    var id : String!
    var userId: String!
    var glucose: String!
    var insulin : String!
    var bsdate : String!
    var status : String!
    var medicationname : String!
//    var bsimages : String!
    
    required init() {
        
    }
}

class GetBloodSugarInfo: EVObject, Codable {
    var results:[AddBloodSugarInfo]?
    required init() {
        
    }
}
