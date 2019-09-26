//
//  RegisterService.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/15/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireJsonToObjects
import Toast
import EVReflection

class RegisterService: NSObject {
    
    static func callWSForAuthentication(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (RegisterInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)\nRequest Parameters:\(params)")
        Alamofire.request(url, method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<RegisterInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(RegisterInfo.self, from: response.data!)
                    debugPrint("SUCCESS JSON:", decodedLog)
                    complitionHandler(decodedLog,response.error)
                }
                catch
                {
                    debugPrint(kSomethingWentWrong)
                    complitionHandler(nil,error)
                }
            }
        }
    }
    
    //Get User data
    static func callWSForGetUser(url:String,httpMethod:HTTPMethod,complitionHandler : @escaping (LoginUser?,Error?) -> Void)
    {
        debugPrint("URL:\(url)")
        Alamofire.request(url, method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<LoginUser>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(LoginUser.self, from: response.data!)
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
    
    static func callWSForLogoutUser(url:String,httpMethod:HTTPMethod,complitionHandler : @escaping (Error?) -> Void)
    {
        debugPrint("URL:\(url)")
        Alamofire.request(url, method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .failure(let error):
                complitionHandler(error)
            case .success:
                complitionHandler(response.error)
            }
        }
    }

}
