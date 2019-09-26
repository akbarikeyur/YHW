//
//  BloodSugarService.swift
//  YourHealthWallet
//
//  Created by Keyur on 06/09/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireJsonToObjects

class BloodSugarService: NSObject {

    static func AddBloodSugarReading(_ param : [String : Any], _ completeonHandler : @escaping (AddBloodSugarInfo?) -> Void) {
        
        Alamofire.request(AddBloodSugarReadingUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddBloodSugarInfo>) in
            completeonHandler(response.result.value)
        }
        
    }
}
