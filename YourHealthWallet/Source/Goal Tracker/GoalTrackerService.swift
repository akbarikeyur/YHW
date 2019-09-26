//
//  GoalTrackerService.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 7/5/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireJsonToObjects
import Toast
import EVReflection

class GoalTrackerService: NSObject {
        
    //MARK: - Add Custom Goal API
    //MARK: -
    static func callWSForAddCustomGoal(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (AddCustomGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)\nRequest Parameters:\(params)")
        Alamofire.request(url, method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddCustomGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddCustomGoalInfo.self, from: response.data!)
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
    
    //MARK: - Add Activity Goal API
    //MARK: -
    static func callWSForActivityGoal(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (AddActivityGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)\nRequest Parameters:\(params)")
        Alamofire.request(url, method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddActivityGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddActivityGoalInfo.self, from: response.data!)
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
    
    //MARK: - Add Sleep Goal API
    //MARK: -
    static func callWSForAddSleepGoal(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (AddSleepGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)\nRequest Parameters:\(params)")
        Alamofire.request(url, method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddSleepGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddSleepGoalInfo.self, from: response.data!)
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
    
    //MARK: - Add Steps Goal API
    //MARK: -
    static func callWSForAddStepsGoal(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (AddStepsGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)\nRequest Parameters:\(params)")
        Alamofire.request(url, method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddStepsGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddStepsGoalInfo.self, from: response.data!)
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
    
    //MARK: - Add Run Goal API
    //MARK: -
    static func callWSForAddRunGoal(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (AddRunGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)\nRequest Parameters:\(params)")
        Alamofire.request(url, method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddRunGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddRunGoalInfo.self, from: response.data!)
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
    
    //MARK: - Add Calories Goal API
    //MARK: -
    static func callWSForAddCaloriesGoal(url:String,httpMethod:HTTPMethod, params:Parameters,complitionHandler : @escaping (AddCaloriesGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)\nRequest Parameters:\(params)")
        Alamofire.request(url, method: httpMethod, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddCaloriesGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddCaloriesGoalInfo.self, from: response.data!)
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
    
    //MARK: - Get Activity Goal API
    //MARK: -
    static func callWSForActivityGetGoal(url:String,httpMethod:HTTPMethod,complitionHandler : @escaping (AddActivityGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)")
        Alamofire.request(url, method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddActivityGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddActivityGoalInfo.self, from: response.data!)
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
    
    //MARK: - Get Sleep Goal API
    //MARK: -
    static func callWSForSleepGetGoal(url:String,httpMethod:HTTPMethod,complitionHandler : @escaping (AddSleepGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)")
        Alamofire.request(url, method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddSleepGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddSleepGoalInfo.self, from: response.data!)
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
    
    //MARK: - Get Steps Goal API
    //MARK: -
    static func callWSForStepsGetGoal(url:String,httpMethod:HTTPMethod,complitionHandler : @escaping (AddStepsGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)")
        Alamofire.request(url, method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddStepsGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddStepsGoalInfo.self, from: response.data!)
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
    
    //MARK: - Get Run Goal API
    //MARK: -
    static func callWSForRunGetGoal(url:String,httpMethod:HTTPMethod,complitionHandler : @escaping (AddRunGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)")
        Alamofire.request(url, method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddRunGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddRunGoalInfo.self, from: response.data!)
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
    
    static func callWSForCaloriesGetGoal(url:String,httpMethod:HTTPMethod,complitionHandler : @escaping (AddCaloriesGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)")
        Alamofire.request(url, method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddCaloriesGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddCaloriesGoalInfo.self, from: response.data!)
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

    //MARK: - Get Custom Goal API
    //MARK: -
    static func callWSForCustomGetGoal(url:String,httpMethod:HTTPMethod,complitionHandler : @escaping (AddCustomGoalInfo?,Error?) -> Void)
    {
        debugPrint("URL:\(url)")
        Alamofire.request(url, method: httpMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddCustomGoalInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(AddCustomGoalInfo.self, from: response.data!)
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
