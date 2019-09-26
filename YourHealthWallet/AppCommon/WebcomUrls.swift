//
//  WebcomUrls.swift
//  YourHealthWallet
//
//  Created by Shridhar on 14/02/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

var BaseUrl = "https://yhw-dot-yhw-app-phase1.appspot.com/api/"

//MARK:- Authentication
//MARK:-

var CreateUserUrl : String {
    return BaseUrl + "auth"
}
var LoginWithNormalUrl : String {
    return BaseUrl + "auth/applogin"
}
var LoginWithFacebbokUrl : String {
    return BaseUrl + "auth/facebook-token/callback"
}
var ForgotPasswordUrl : String {
    return BaseUrl + "auth/reset"
}
var HRAUrl : String {
    return BaseUrl + "userhras"
}
var UpdateHRAUrl : String {
    return BaseUrl + "auth/updateHRA"
}
var GetHRAUrl :String{
    return BaseUrl + "auth/\(AppUserDefaults.getUserID())/userhras"
}
var LogOutUrl : String {
    return BaseUrl + "auth/logout"
}

//MARK:- Goals
//MARK:-

var AddCustomGoalUrl : String {
    return BaseUrl + "userCgoals"
}
var AddActivityGoalUrl : String {
    return BaseUrl + "userAcgoals"
}
var AddSleepGoalUrl : String {
    return BaseUrl + "userAslgoals"
}
var AddStepsGoalUrl : String {
    return BaseUrl + "userAstgoals"
}
var AddRunGoalUrl : String {
    return BaseUrl + "userrungoals"
}
var AddCaloriesGoalUrl : String {
    return BaseUrl + "usercalgoals"
}

var GetActivityGoalUrl :String{
    return BaseUrl + "auth/\(AppUserDefaults.getUserID())/userAcgoals"
}
var GetSleepGoalUrl :String{
    return BaseUrl + "auth/\(AppUserDefaults.getUserID())/userAslgoals"
}
var GetStepsGoalUrl :String{
    return BaseUrl + "auth/\(AppUserDefaults.getUserID())/userAstgoals"
}
var GetRunGoalUrl :String{
    return BaseUrl + "auth/\(AppUserDefaults.getUserID())/userrungoals"
}
var GetCaloriesGoalUrl :String{
    return BaseUrl + "auth/\(AppUserDefaults.getUserID())/usercalgoals"
}
var GetCustomGoalUrl :String{
    return BaseUrl + "auth/\(AppUserDefaults.getUserID())/userCgoals"
}

//MARK:- Medication
//MARK:-

var AdduserMedicinesUrl : String {
    return BaseUrl + "usermedicines"
}

var GetuserMedicinesUrl : String {
    return BaseUrl + "usermedicines/\(AppUserDefaults.getUserID())/getallusermeds"
}


//MARK:- Reminder
//MARK:-
var GetRemindersUrl : String {
    return BaseUrl + "userreminders"
}

var CreateRemindersUrl : String {
    return BaseUrl + "userreminders"
}


//MARK:- Add Heart Rate
//MARK:-

var AddHeartRateReadingUrl : String {
    return BaseUrl + "userheartrates"
}

var GetHeartRateReadingUrl : String {
    return BaseUrl + AppUserDefaults.getUserID() + "/userheartrates"
}


//MARK:- Add Blood Sugar
//MARK:-

var AddBloodSugarReadingUrl : String {
    return BaseUrl + "userbs"
}

var GetBloodSugarReadingUrl : String {
    return BaseUrl + AppUserDefaults.getUserID() + "/userbs"
}

//MARK:- Blood Pressure
//MARK:-

var AddBloodPressureReadingUrl : String {
    return BaseUrl + "userbps"
}

//MARK:- Add Weight
//MARK:-

var AddWeightUrl : String {
    return BaseUrl + "adduserWeights"
}
