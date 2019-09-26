//
//  AddWeightInfo.swift
//  YourHealthWallet
//
//  Created by Keyur on 01/09/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import EVReflection

class AddWeightInfo: EVObject, Codable {

    var weightadddatetime: String!
    var weight:Int!
    var bodyfats: String!
//    var images: [String]!
    var notes:String!
    var id:String!
    var userId:String!
    
    required init() {
    }
}

class GetWeightInfo: EVObject, Codable {
    var results:[AddWeightInfo]?
    required init() {
        
    }
}

