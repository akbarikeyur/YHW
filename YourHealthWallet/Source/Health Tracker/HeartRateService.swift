//
//  HeartRateService.swift
//  YourHealthWallet
//
//  Created by Keyur on 04/09/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireJsonToObjects

class HeartRateService: NSObject {

    static func AddHeartRateReading(_ param : [String : Any], imgArr : [UIImage], _ completeonHandler : @escaping (AddHeartRateInfo?) -> Void) {
        /*
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in param {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            /*
            for i in 0..<imgArr.count
            {
                if let imageData = UIImageJPEGRepresentation(imgArr[i], 1.0)
                {
                    multipartFormData.append(imageData, withName: "hrimages", fileName: "hrimages.png", mimeType: "image/png")
                }
            }
            */
        }, usingThreshold: UInt64.init(), to: AddHeartRateReadingUrl, method: .post, headers: nil) { (result) in
            switch result{
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseObject { (response: DataResponse<AddHeartRateInfo>) in
                    completeonHandler(response.result.value)
                }
            case .failure(let error):
                displayToast(error.localizedDescription)
                break
            }
        }
        */
        
        Alamofire.request(AddHeartRateReadingUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<AddHeartRateInfo>) in
            completeonHandler(response.result.value)
        }
 
    }
    
    static func callWSForGetHeartRate(complitionHandler : @escaping (GetHeartRateInfo?,Error?) -> Void)
    {
//        Alamofire.request(GetHeartRateReadingUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), method: .get, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
//
//            switch response.result {
//            case .success:
//
//                break
//            case .failure(let error):
//                complitionHandler(nil,error)
//                break
//            }
//
//        }
        
        Alamofire.request(GetHeartRateReadingUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), method: .get, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response: DataResponse<GetHeartRateInfo>) in
            
            switch response.result {
            case .failure(let error):
                complitionHandler(nil,error)
            case .success:
                do{
                    let jsonDecoder = JSONDecoder()
                    let decodedLog = try jsonDecoder.decode(GetHeartRateInfo.self, from: response.data!)
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
