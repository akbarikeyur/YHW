//
//  HRAService.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 5/12/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireJsonToObjects
import EVReflection

class HRAService: NSObject {

    static func callWSForHRA(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (HRAInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)\nRequest Parameters:\(params)")
        Alamofire.request(url, method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<HRAInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(HRAInfo.self, from: response.data!)
                    debugPrint("SUCCESS JSON:", decodedLog)
                    complitionHandler(decodedLog,response.error)
                }
                catch
                {
                    debugPrint(kSomethingWentWrong)
                }
            }
        }
    }
    
    static func callWSForUpdateHRA(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (Error?) -> Void)
    {
        debugPrint("URL:\(url)\nRequest Parameters:\(params)")
        Alamofire.request(url, method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .failure(let error):
                complitionHandler(error)
            case .success:
                complitionHandler(response.error)
            }
        }
    }
    
    static func callWSForGetHRA(url:String,httpMethod:HTTPMethod,complitionHandler : @escaping (HRAInfo?,Error?) -> Void)
    {
        Alamofire.request(url, method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<HRAInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(HRAInfo.self, from: response.data!)
                    debugPrint("SUCCESS JSON:", decodedLog)
                    complitionHandler(decodedLog,response.error)
                }
                catch
                {
                    debugPrint(kSomethingWentWrong)
                }
            }
        }
    }
}
