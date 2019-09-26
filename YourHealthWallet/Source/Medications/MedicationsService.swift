//
//  MedicationsService.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/22/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireJsonToObjects

class MedicationsService: NSObject {

    static func callWSForAddMedication(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (AddMedicationInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)\nRequest Parameters:\(params)")
        Alamofire.request(url, method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddMedicationInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddMedicationInfo.self, from: response.data!)
                    debugPrint("SUCCESS JSON:", decodedLog)
                    complitionHandler(decodedLog,response.error)
                }
                catch
                {
                    complitionHandler(nil,response.error)
                    debugPrint(kSomethingWentWrong)
                }
            }
        }
    }
    
    static func callWSForGetMedication(url:String,httpMethod:HTTPMethod,complitionHandler : @escaping (GetMedicationInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)")
        Alamofire.request(url, method: httpMethod, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<GetMedicationInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(GetMedicationInfo.self, from: response.data!)
                    debugPrint("SUCCESS JSON:", decodedLog)
                    complitionHandler(decodedLog,response.error)
                }
                catch
                {
                    complitionHandler(nil,response.error)
                    debugPrint(kSomethingWentWrong)
                }
            }
        }
    }
}
