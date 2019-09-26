//
//  AddWeightService.swift
//  YourHealthWallet
//
//  Created by Keyur on 01/09/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireJsonToObjects

class AddWeightService: NSObject {
    
    static func callWSForAddWeight(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (AddWeightInfo?) -> Void)
    {
        debugPrint("URL:\(url)\nRequest Parameters:\(params)")
        Alamofire.request(url + "?access_token=" + AppUserDefaults.getUserAuthtoken(), method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddWeightInfo>) in
            
            complitionHandler(response.result.value)
        }
    }
    
}
