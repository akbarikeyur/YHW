//
//  AppUserDefaults.swift
//  
//
//  Created by Shridhar on 6/2/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//NSUserDefaults Keys

//User-----
let kIsUserLoggedIn = "isUserLoggedIn"
let kUserId = "userId"

//Goals
let kIsAddedActiveGoal = "isAddedActiveGoal"
let kIsAddedStepsGoal = "isAddedStepsGoal"
let kIsAddedSleepGoal = "isAddedSleepGoal"
let kIsAddedCustomGoal = "isAddedCustomGoal"
let kIsAddedRunGoal = "isAddedRunGoal"
let kIsAddedCaloriesGoal = "isAddedCaloriesGoal"

//HRA------
let kIsHRACompleted = "isHRACompleted"
let kHRAFeet = "newhft"
let kHRAInch = "newhin"
let kHRACM = "newhcm"
let kHRAKG = "newwkg"
let kHRALB = "newwlb"
let kHRAEF = "newef"
let kHRAMC = "newmc"
let kHRACT = "newct"
let kHRAMD = "newmd"
let kHRADateAdded = "dateadded"
let kHRAAGE = "age"
let kHRAGENDER = "gender"
let kIsFeet = "isFeet"
let kIsKg = "isKg"
let kUserWeight = "userWeight"
let kUserHeight = "userHeight"

let kAuthtoken = "Authtoken"
let kDeviceToken = "DeviceToken"
let kIsDisplayedHomeTips = "IsDisplayedHomeTips"
let kIsDisplayedHambergerTips = "IsDisplayedHambergerTips"
let kDivvyBannerHeight = "DivvyBannerHeight"
let kNotificationStatus = "kNotificationStatus"

let kId = "kId"
let kFirstName = "kFirstName"
let kLastName = "kLastName"
let kPhoneNumber = "kPhoneNumber"
let kZipCode = "kZipCode"
let kEmailID = "kEmailID"
let kGender = "kGender"
let kRoleId = "kRoleId"
let kUserImage = "kUserImage"
let kOldUserId = "kIkOldUserIdd"

private let ApplicationUserDefaults = UserDefaults.standard

class AppUserDefaults: NSObject {
    
    static func saveUserDefaults() {
        ApplicationUserDefaults.synchronize()
    }

    static func restoreDefaultValuses() {
        AuthToken = ""
    }
    
    static var AuthToken : String {
        get {
            let token = ApplicationUserDefaults.value(forKey: kAuthtoken) as? String
            
            return (token != nil) ? token! : ""
        }
        
        set {
            ApplicationUserDefaults.setValue(newValue, forKey: kAuthtoken)
            
            saveUserDefaults()
        }
    }
    
    static func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    //MARK: - Authenticaion token & is user logedin
    //MARK: -

    static func isUserLoggedIn() -> Bool {
        return ApplicationUserDefaults.bool(forKey: kIsUserLoggedIn)
    }
    
    static func setUserLoggedIn(_ status:Bool) {
        
        if status == false {
            
        }
        ApplicationUserDefaults.set(status, forKey: kIsUserLoggedIn)
    }
    
    static func setUserAuthtoken(_ authToken:String) {
        
        ApplicationUserDefaults.set(authToken, forKey: kAuthtoken)
    }
    
    static func getUserAuthtoken() -> String {
        return ApplicationUserDefaults.value(forKey: kAuthtoken) as! String
    }
    
    //MARK: - UserId
    //MARK: -

    static func setUserID(_ userId:String) {
        
        ApplicationUserDefaults.set(userId, forKey: kUserId)
    }
    
    static func getUserID() -> String {
        return ApplicationUserDefaults.value(forKey: kUserId) as! String
    }

    //MARK: - HRA completed or not
    //MARK: -
    static func isHRACompleted() -> Bool {
        return ApplicationUserDefaults.bool(forKey: kIsHRACompleted)
    }
    
    static func setHRACompleted(_ status:Bool) {
        
        if status == false {
            
        }
        ApplicationUserDefaults.set(status, forKey: kIsHRACompleted)
    }
    
    //MARK: - Goals Added checking
    //MARK: -
    static func isAddedActiveGoal() -> Bool {
        return ApplicationUserDefaults.bool(forKey: kIsAddedActiveGoal)
    }
    
    static func setAddedActiveGoal(_ status:Bool) {
        
        if status == false {
            
        }
        ApplicationUserDefaults.set(status, forKey: kIsAddedActiveGoal)
    }
    
    static func isAddedStepsGoal() -> Bool {
        return ApplicationUserDefaults.bool(forKey: kIsAddedStepsGoal)
    }
    
    static func setAddedStepsGoal(_ status:Bool) {
        
        if status == false {
            
        }
        ApplicationUserDefaults.set(status, forKey: kIsAddedStepsGoal)
    }
    
    static func isAddedSleepGoal() -> Bool {
        return ApplicationUserDefaults.bool(forKey: kIsAddedSleepGoal)
    }
    
    static func setAddedSleepGoal(_ status:Bool) {
        
        if status == false {
            
        }
        ApplicationUserDefaults.set(status, forKey: kIsAddedSleepGoal)
    }
    
    static func isAddedCustomGoal() -> Bool {
        return ApplicationUserDefaults.bool(forKey: kIsAddedCustomGoal)
    }
    
    static func setAddedCustomGoal(_ status:Bool) {
        
        if status == false {
            
        }
        ApplicationUserDefaults.set(status, forKey: kIsAddedCustomGoal)
    }
    
    static func isAddedRunGoal() -> Bool {
        return ApplicationUserDefaults.bool(forKey: kIsAddedRunGoal)
    }
    
    static func setAddedRunGoal(_ status:Bool) {
        
        if status == false {
            
        }
        ApplicationUserDefaults.set(status, forKey: kIsAddedRunGoal)
    }
    
    static func isAddedCaloriesGoal() -> Bool {
        return ApplicationUserDefaults.bool(forKey: kIsAddedCaloriesGoal)
    }
    
    static func setAddedCaloriesGoal(_ status:Bool) {
        
        if status == false {
            
        }
        ApplicationUserDefaults.set(status, forKey: kIsAddedCaloriesGoal)
    }
    
    //MARK: - Height & weight set
    //MARK: -
    static func isFeetType() -> Bool {
        return ApplicationUserDefaults.bool(forKey: kIsFeet)
    }
    
    static func setFeetType(_ status:Bool) {
        
        if status == false {
            
        }
        ApplicationUserDefaults.set(status, forKey: kIsFeet)
    }
    
    static func isKgType() -> Bool {
        return ApplicationUserDefaults.bool(forKey: kIsKg)
    }
    
    static func setKgType(_ status:Bool) {
        
        if status == false {
            
        }
        ApplicationUserDefaults.set(status, forKey: kIsKg)
    }
    
    static func setUserAge(_userAge:Int){
        
        ApplicationUserDefaults.set(_userAge, forKey: kHRAAGE)

    }
    static func getUserAge() -> Int{
        
        return ApplicationUserDefaults.value(forKey: kHRAAGE) as! Int

    }
    
    static func setUserSex(_userAge:String){
        
        ApplicationUserDefaults.set(_userAge, forKey: kHRAGENDER)
        
    }
    static func getUserSex() -> String{
        
        return ApplicationUserDefaults.value(forKey: kHRAGENDER) as! String
        
    }
    
    static func setUserWeight(_weight:Double){
        
        ApplicationUserDefaults.set(_weight, forKey: kUserWeight)

    }
    
    static func getUserWeight() -> Double{
        
        return ApplicationUserDefaults.value(forKey: kUserWeight) as! Double
        
    }
    
    static func setUserHeight(_height:Double){
        
        ApplicationUserDefaults.set(_height, forKey: kUserHeight)
        
    }
    
    static func getUserHeight() -> Double{
        
        return ApplicationUserDefaults.value(forKey: kUserHeight) as! Double

    }

}
