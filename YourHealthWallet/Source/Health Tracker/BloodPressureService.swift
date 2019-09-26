//
//  BloodPressureService.swift
//  YourHealthWallet
//
//  Created by Keyur on 29/08/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireJsonToObjects

class BloodPressureService: NSObject {

    static func callWSForAddBloodPressureReading(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (AddBloodPressureInfo?) -> Void)
    {
        Alamofire.request(AddBloodPressureReadingUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddBloodPressureInfo>) in
            complitionHandler(response.result.value)
        }
    }
}
