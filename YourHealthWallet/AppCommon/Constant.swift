//
//  Constant.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/16/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import Foundation

struct DATE_FORMAT {
    static let DISP_DATE = "dd MMM, yyyy"
    static let DISP_DATE_WITH_DAY = "EEEE, dd MMM"
    static let DISP_DATE_WITH_TIME = "dd MMM, yyyy, HH:mm a"
    static let DISP_DATE_WITH_FULL_MONTH = "dd MMMM, yyyy"
    static let SERVER_DATE = "yyyy-MM-dd'T'HH:mm:ss"
    static let DISP_TIME = "HH:mm:ss"
    static let MEDICATION_DATE = "yyyy-MM-dd"
    static let MEDICATION_SERVER_DATE = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let MEDICATION_TIME = "hh:mm a"
    
    static let REMINDER_DATE = "yyyy-MM-dd"
    static let REMINDER_SERVER_DATE = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let REMINDER_TIME = "hh:mm a"
    
    static let WEEKDAY_CHART_START = "EEE dd"
    static let WEEKDAY_CHART_END = "dd MMM,yyyy"
    static let CHART_X_FORMATE_DAY = "hh a"
    static let CHART_X_FORMATE_WEEK = "EEE"
    
    static let SLEEP_BEDANDWAKEUPTIME = "hh:mm"
    static let SLEEP_TIMEFORMATE = "a"
    
}

struct TIME_FORMAT {
    static let DISP_TIME = "hh:mm a"
}

struct CONSTANT{
    static let TIME_ZONE = "Australia/Sydney"
}

//MARK: Alert Messages
public struct StatusCode {
    static let kAPILoginSuccess = 200
    static let kAPIRegisterSuccess = 201
    static let kAPIFailure = 401
}

//MARK: Alert Messages
public let kSomethingWentWrong = "Oops! Something went wrong. Plase try again"
public let kNoInternetConnection = "No Internet Connection!"
public let kVerifying = "Verifying.."

public let kEmailEmpty = "Please enter email."
public let kEmailValid = "Please enter valid email."
public let kPasswordEmpty = "Please enter password."
public let kFirstNameEmpty = "Please enter firstname."
public let kLastNameEmpty = "Please enter lastname."
public let kSelectHeight = "Please enter Height."
public let kSelectWeight = "Please enter Weight."
public let kSelectAge = "Please enter Age."
public let kSelectAtLeast = "Please select at least one."

//Add Goals
public let kSuccessAddGoal = "Your goal is successfully added."
public let kSuccessEditedGoal = "Your goal is successfully edited."

public let kSelectActivity = "Please choose your activity."
public let kSelectSteps = "Please select your steps."
public let kSelectPeriod = "Please select your period."
public let kSelectMile = "Please select your mile."

public let kEnterActiveTime = "Please enter active time."
public let kEnterSleepTime = "Please enter sleep time."

//Add Activity
public let kEnterAddActivityDate = "Please choose date."
public let kEnterAddActivityDescription = "Please enter description."
public let kEnterAddActivitySleepingTime = "Please enter sleeping time."
public let kEnterAddActivityWakeupTime = "Please enter wakeup time."
public let kEnterAddActivityNote = "Please enter note."

//Add Weight
public let kEnterAddWeight = "Please enter weight."
public let kEnterBodyFate = "Please enter body fats."
public let kEnterWeightImage = "Please add at least one image."
public let kEnterAddWeightNote = "Please enter note."

//Add Medication
public let kEnterMedicationName = "Please enter medication name."
public let kEnterMedicationType = "Please select medication type."
public let kEnterEnterReminderTime = "Please enter reminder time."
public let kEnterMedDosage = "Please enter dosage."
public let kEnterMedUnit = "Please select unit."
public let kEnterMedScheduleTime = "Please enter schedule time."
public let kEnterMedDuration = "Please select duration."
public let kEnterMedDays = "Please select days."
public let kEnterMedMedium = "Please select medium."
public let kEnterMedShape = "Please select shape."
public let kEnterMedColor = "Please select color."
public let kEnterMedInstuction = "Please select instruction."
public let kEnterMedNote = "Please enter note."
public let kSuccessMedicationAdded = "Your medication is successfully added."
public let kSuccessMedicationEdited = "Your medication is successfully edited."

//Add Activity
public let kEnterAddActiveTime = "Please enter active time."
public let kEnterCalories = "Please enter calories."
public let kEnterSteps = "Please enter steps."
public let kEnterKilometer = "Please enter kilometers."

public let kEnterAddedWalk = "You've saved walk activity"
public let kEnterAddedRun = "You've saved run activity"
public let kEnterAddedCycle = "You've saved cycle activity"
public let kEnterAddedSleep = "You've saved sleep activity"
public let kEnterDateValidation = "End time is earlier than start time"

//MARK: API Request parameters

//Normal Login
public struct LoginRequestKey {
    static let kLoginEmail = "email"
    static let kLoginPassword = "password"
}

//Register
public struct RegisterRequestKey {
    static let kRegisterEmail = "email"
    static let kRegisterPassword = "password"
    static let kRegisterFirstname = "firstname"
    static let kRegisterLastname = "lastname"
    static let kRegisterHraInd = "hra_ind"
}

//Facebook Login
public struct FBLoginRequestKey {
    static let kAccessToken = "access_token"
}


//Add cCstom Goal
public struct AddCustomGoalRequestKey {
    static let kActivityname = "activityname"
    static let kCalories = "calories"
    static let kActivityfreq = "activityfreq"
}

//Add Activity Goal
public struct AddActivityGoalRequestKey {
    static let kActivitfor = "Activefor"
    static let kActivityfreq = "Activefreq"
}

//Add Steps Goal
public struct AddStepsGoalRequestKey {
    static let kWillWalk = "Willwalk"
    static let kStepsfreq = "Addstepsfreq"
}

//Add Sleep Goal
public struct AddSleepGoalRequestKey {
    static let kWillSleep = "Willsleep"
    static let kSleepfreq = "sleepfreq"
}

//Add Run Goal
public struct AddRunGoalRequestKey {
    static let kRunFor = "runfor"
    static let kRunfreq = "runfreq"
}

//Add Calories Goal
public struct AddCaloriesGoalRequestKey {
    static let kBurnCalories = "burncalories"
    static let kBurnFreq = "burnfreq"
}

//Add Medication
public struct AddMedicationRequestKey {

    static let kMedicationName = "medicationname"
    static let kMedicationstartdate = "medicationstartdate"
    static let kMedicationcategory = "medicationcategory"
    static let kMedicationtype = "medicationtype"
    static let kRemindertimes = "remindertimes"
    static let kDosage = "dosage"
    static let kDosageunit = "dosageunit"
    static let kDuration = "duration"
    static let kDaysfrequency = "daysfrequency"
    static let kMedium = "medium"
    static let kShape = "shape"
    static let kColor = "color"
    static let kInstructions = "instructions"
    static let kMedicationnotes = "medicationnotes"
    static let kMedicationnInd = "medtaken_ind"

}

//Add Reminder
public struct AddReminderRequestKey {
    static let kReminderType = "remindertype"
    static let kReminderStartDate = "reminderstartdate"
    static let kReminderInterval = "repeatinterval"
    static let kUserId = "userId"
    
}

//Add Reading - Heart rate
public struct AddHeartRateKey {
    static let kHRDate = "hrdate"
    static let kHRRate = "heartrate"
    static let kHRImage = "hrimages"
    static let kHRUserId = "userId"
}

//Add Reading - Blood Sugar
public struct AddBloodSugarKey {
    static let kBSGlucose = "glucose"
    static let kBSInsulin = "insulin"
    static let kBSStatus = "status"
    static let kBSMedication = "medicationname"
    static let kBSDate = "bsdate"
    static let kBSUserId = "userId"
    static let kBSImage = "bsimages"
}

//Add Reading - Blood Pressure
public struct AddBloodPressureKey {
    static let kBPDate = "bpdate"
    static let kBPSystolic = "systolic"
    static let kBPDiastolic = "diastolic"
    static let kBPPulserate = "pulserate"
    static let kBPMedicationname = "medicationname"
    static let kBPImage = "bpimages"
    static let kBPId = "id"
    static let kBPUserId = "userId"
}

//Add Reading - Add Weight
public struct AddWeightKey {
    static let kWDate = "weightadddatetime"
    static let kWWight = "weight"
    static let kWBodyFacts = "bodyfats"
    static let kWImage = "images"
    static let kWNote = "notes"
    static let kWId = "id"
    static let kWUserId = "userId"
}

public struct NOTIFICATION{
    static let ON_UPDATE_USER_LOCATION:String = "ON_UPDATE_USER_LOCATION"
}

var dictReminder : [String : [String : Any]] = ["walk" : ["color" : PurpuleColor, "icon" : "walk"], "run" : ["color" : OrangeColor, "icon" : "run"], "Sleep" : ["color" : BlueColor, "icon" : "sleep"], "Steps" : ["color" : VoiletColor, "icon" : "steps"], "Medication" : ["color" : FTPurpleColor, "icon" : "medications"], "Doctor visits" : ["color" : Blue2Color, "icon" : "stethoscope"], "Heart rate check" : ["color" : GreenColor, "icon" : "heart_rate"], "BP check" : ["color" : GoldColor, "icon" : "bp_check"], "Blood sugar check" : ["color" : RedColor, "icon" : "blood_sugar"], "Medicine reviews" : ["color" : GreenLightColor, "icon" : "pill_white"]]





