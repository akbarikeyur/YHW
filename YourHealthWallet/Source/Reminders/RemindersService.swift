//
//  RemindersService.swift
//  YourHealthWallet
//
//  Created by Shridhar on 14/02/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireJsonToObjects

class RemindersService: NSObject {

    static func callWSForGetReminders(url:String,httpMethod:HTTPMethod,complitionHandler : @escaping (GetReminderInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)")
        Alamofire.request(url, method: httpMethod, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<GetReminderInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(GetReminderInfo.self, from: response.data!)
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
    
    static func CreateReminder(_ param : [String : Any], _ complitionHandler : @escaping (AddReminderInfo?) -> Void) {
        
        Alamofire.request(CreateRemindersUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddReminderInfo>) in //ReminderInfo is model class response

            complitionHandler(response.result.value) //value is the response

        }
        
    }
    
    class CuriosityLog: Codable {
        enum Discovery: String, Codable {
            case rock, water, martian
        }
        
        var sol: Int!
        var discoveries: [Discovery]!
        var childObject: ChildClass!
    }
    
    class ChildClass: Codable {
        var count: Int?
        var name: String?
        
        init() {
            
        }
    }
    
    static func EncodeDecode()  {
        do {
            
            // Create a log entry for Mars sol 42
            let logSol42 = CuriosityLog()
            logSol42.sol = 42
            logSol42.discoveries = [.rock, .rock, .rock, .rock]
            logSol42.childObject = ChildClass()
            logSol42.childObject?.count = 10
            logSol42.childObject?.name = "YHW"
            
            let jsonEncoder = JSONEncoder() // One currently available encoder
            
            // Encode the data
            let jsonData = try jsonEncoder.encode(logSol42)
            // Create a String from the data
            let jsonString = String(data: jsonData, encoding: .utf8) // "{"sol":42,"discoveries":["rock","rock","rock","rock"]}"
            
            let jsonDecoder = JSONDecoder() // Pair decoder to JSONEncoder
            
            // Attempt to decode the data to a CuriosityLog object
            let decodedLog = try jsonDecoder.decode(CuriosityLog.self, from: jsonData)
            print(decodedLog.sol)
            
        } catch  {
            
        }
    }
}
