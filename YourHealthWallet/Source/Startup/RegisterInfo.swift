//
//  RegisterInfo.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/15/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import Foundation
import EVReflection

class RegisterInfo: EVObject, Codable {
    var statusCode:Int!
    var message: String!
    var name: String!
    var code: String!
    var data: UserData?
    required init() {
        
    }
}

class UserData: EVObject, Codable {
    var id: String?
    var ttl: Int?
    var userid:String?
    var firstname, lastname: String?
    var email: String?
    var etheraddress: String?
    var hra_ind:Bool?
    required init() {
        
    }
}

class LoginUser: EVObject, Codable {
    var id: String?
    var firstname, lastname: String?
    var email: String?
    var hra_ind:Bool?
    var emailVerified:Bool?
    required init() {
        
    }
}
