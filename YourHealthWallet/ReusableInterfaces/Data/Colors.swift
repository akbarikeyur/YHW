//
//  Colors.swift
//
//
//  Created by Shridhar on 6/3/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

var ClearColor : UIColor = UIColor.clear //0
var WhiteColor : UIColor = UIColor.white //1
var RedColor : UIColor = UIColor.red //2
var WhiteBorderColor : UIColor = UIColor.white.withAlphaComponent(0.13) //3
var BlackSearchTextFieldColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:1) //4
var YellowColor = UIColor(red:0.95, green:0.72, blue:0.31, alpha:1) //5
var GreenLightColor = UIColor(red:0.24, green:0.84, blue:0.72, alpha:1) //6
var PurpuleColor = UIColor(red:0.42, green:0.36, blue:0.91, alpha:1) //7
var OrangeColor = UIColor(red:0.98, green:0.49, blue:0.35, alpha:1) //8
var ButtonOrangeColor = UIColor(red:0.81, green:0.47, blue:0.16, alpha:1) //9
var ButtonBlueLightColor = UIColor(red:0.26, green:0.42, blue:0.71, alpha:1) //10
var ButtonBlueColor = UIColor(red:0, green:0.66, blue:1, alpha:1)//11
var GrayColor = UIColor.gray //12
var GoldColor = UIColor(red:0.87, green:0.75, blue:0.28, alpha:1) //13
var BlueColor = UIColor(red:0.12, green:0.49, blue:0.78, alpha:1) //14
var DarkGrayColor = UIColor.darkGray // 15
var DarkBlueColor = UIColor(red:0.07, green:0.46, blue:0.84, alpha:1) //16
var DarkBlue1Color = UIColor(red:0.31, green:0.46, blue:0.73, alpha:1) //17
var Yellow1Color = UIColor(red:1, green:0.88, blue:0.46, alpha:1) // 18
var MedicationBackColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)//401
var MonthButtonBackColor = UIColor(red:0.49, green:0.18, blue:0.58, alpha:1)//402
var QuestionTitleColor = UIColor(red:0.24, green:0.24, blue:0.24, alpha:1)//403
var HRASequenceBlueColor = UIColor(red:0, green:0.4, blue:1, alpha:1)//404
var FitnessTrackerRunPinkColor = UIColor(red:0.96, green:0.31, blue:0.64, alpha:1)//405
var FitnessTrackerCycleSkyeColor = UIColor(red:0, green:0.78, blue:1, alpha:1)//406
var FitnessTrackerSleepColor = UIColor(red:0.24, green:0.74, blue:0.7, alpha:1)//407
var WeightResultGraph1Color = UIColor(red:1, green:0.78, blue:0.39, alpha:1)//408
var WeightResultGraph2Color = UIColor(red:0.36, green:0.84, blue:0.39, alpha:1)//409
var WeightResultGraph3Color = UIColor(red:1, green:0.39, blue:0.39, alpha:1)//410

 // 19

//Amisha Colors
var VoiletColor = UIColor(red:0.63, green:0.27, blue:0.74, alpha:1) // 19
var LightGrayColor = UIColor(red:0.45, green:0.45, blue:0.45, alpha:1) //20
var ExtraLightGrayColor = UIColor(red:0.45, green:0.45, blue:0.45, alpha:0.5) //21
var FTBlueColor = UIColor(red:0.37, green:0.31, blue:0.84, alpha:1) //22
var FTDarkBlueColor = UIColor(red:0.24, green:0.18, blue:0.7, alpha:1) //23
var FTPurpleColor = UIColor(red:0.74, green:0.06, blue:0.88, alpha:1) //24
var FTAddActivityButttonColor = UIColor(red:0.22, green:0.16, blue:0.68, alpha:1) //25
var FTAddActivityTitleColor = UIColor(red:0.34, green:0.27, blue:0.78, alpha:1) //26
var FTStartActivityViewColor = UIColor(red: 0.25, green: 0.14, blue: 0.73, alpha: 1)//27
var HRBlueColor = UIColor(red: 0.1, green: 0.13, blue: 0.62, alpha: 1)//28


//Shridhar Colors
var Yellow2Color = UIColor(red:1, green:0.97, blue:0.58, alpha:1)//301
var Gray2Color = UIColor(red:0, green:0.36, blue:0.32, alpha:1) // 302
var DividerColor = UIColor(red:0.59, green:0.59, blue:0.59, alpha:1) //303
var Blue2Color = UIColor(red:0, green:0.75, blue:0.97, alpha:1) //304
var Orange2Color = UIColor(red:0.91, green:0.56, blue:0.22, alpha:1) //305
var Orange3Color = UIColor(red:0.97, green:0.48, blue:0.15, alpha:1) //306
var GreenColor = UIColor(red:0.07, green:0.66, blue:0.57, alpha:1) //307

enum ColorType : Int32 {
    case Clear = 0
    case White = 1
    case Red = 2
    case WhiteBorder = 3
    case BlackSearchTextField = 4
    case Yellow = 5
    case GreenLight = 6
    case Purpule = 7
    case Orange = 8
    case ButtonOrange = 9
    case ButtonBlueLight = 10
    case ButtonBlue = 11
    case Gray = 12
    case Gold = 13
    case Blue = 14
    case DarkGray = 15
    case DarkBlue = 16
    case DarkBlue1 = 17
    case Yellow1 = 18
    case Voilet = 19
    case LightGray = 20
    case ExtraLightGray = 21
    case FTBlue = 22
    case FTDarkBlue = 23
    case FTPurple = 24
    case FTAddActivityButtton = 25
    case FTAddActivityTitle = 26
    case FTStartActivityViewBlueColor = 27
    case HRBlue = 28
    case MedicationBack = 401
    case MonthButtonColor = 402
    case QuestionsColor = 403
    case HRASequenceColor = 404
    case FitnessRunPinkColor = 405
    case FitnessCycleSkyeColor = 406
    case FitnessSleepColor = 407
    case WeightGraph1Color = 408
    case WeightGraph2Color = 409
    case WeightGraph3Color = 410
    case Yellow2 = 301
    case Gray2 = 302
    case Divider = 303
    case Blue2 = 304
    case Orange2 = 305
    case Orange3 = 306
    case Green = 307
}

extension ColorType {
    var value: UIColor {
        get {
            switch self {
            case .Clear: //0
                return ClearColor
            case .White: //1
                return WhiteColor
            case .Red: //2
                return RedColor
            case .WhiteBorder: //3
                return WhiteBorderColor
            case .BlackSearchTextField: //4
                return BlackSearchTextFieldColor
            case .Yellow: //5
                return YellowColor
            case .GreenLight: //6
                return GreenLightColor
            case .Purpule: //7
                return PurpuleColor
            case .Orange: //8
                return OrangeColor
            case .ButtonOrange: //9
                return ButtonOrangeColor
            case .ButtonBlueLight: //10
                return ButtonBlueLightColor
            case .ButtonBlue: //11
                return ButtonBlueColor
            case .Gray: //12
                return GrayColor
            case .Gold: //13
                return GoldColor
            case .Blue: //14
                return BlueColor
            case .DarkGray: //15
                return DarkGrayColor
            case .DarkBlue: //16
                return DarkBlueColor
            case .DarkBlue1: //17
                return DarkBlue1Color
            case .Yellow1: // 18
                return Yellow1Color
            case .Voilet: // 19
                return VoiletColor
            case .LightGray: // 20
                return LightGrayColor
            case .ExtraLightGray: //21
                return ExtraLightGrayColor
            case .FTBlue: //22
                return FTBlueColor
            case .FTDarkBlue: //23
                return FTDarkBlueColor
            case .FTPurple: //24
                return FTPurpleColor
            case .FTAddActivityButtton: //25
                return FTAddActivityButttonColor
            case .FTAddActivityTitle: //26
                return FTAddActivityTitleColor
            case .FTStartActivityViewBlueColor: // 27
                return FTStartActivityViewColor
            case .HRBlue: //28
                return HRBlueColor
            case .MedicationBack: // 401
                return MedicationBackColor
            case .MonthButtonColor: // 402
                return MonthButtonBackColor
            case .QuestionsColor: // 403
                return QuestionTitleColor
            case .HRASequenceColor: // 404
                return HRASequenceBlueColor
            case .FitnessRunPinkColor: // 405
                return FitnessTrackerRunPinkColor
            case .FitnessCycleSkyeColor: // 406
                return FitnessTrackerCycleSkyeColor
            case .FitnessSleepColor: // 407
                return FitnessTrackerSleepColor
            case .WeightGraph1Color: // 408
                return WeightResultGraph1Color
            case .WeightGraph2Color: // 409
                return WeightResultGraph2Color
            case .WeightGraph3Color: // 410
                return WeightResultGraph3Color
            case .Yellow2: //301
                return Yellow2Color
            case .Gray2: //302
                return Gray2Color
            case .Divider: //303
                return DividerColor
            case .Blue2: //304
                return Blue2Color
            case .Orange2: //305
                return Orange2Color
            case .Orange3: //306
                return Orange3Color
            case .Green: //307
                return GreenColor
            }
        }
    }
}



enum GradientColorType : Int32 {
    case Clear = 0
    case Blue = 1
    case Voilet = 2
    case LightBlue = 3
    case ReminderYellow = 4
    case YHWTokenTopDarkBlue = 5
    case YHWTokenMiddleDarkBlue = 6
    case HealthTrackerOrange = 7
    case HealthTrackerGreen = 8
    case MedicationsPurpule = 9
    case FitnessTrackerBlue = 10
    case FitnessTrackerWalkOrange = 11
    case FitnessTrackerRunPink = 12
    case FitnessTrackerCycleSkye = 13
    case FitnessTrackerSleepColor = 14
    case ActivityAddGoalColor = 15
    case FTWeightVoiletColor = 16
}

extension GradientColorType {
    var layer : GradientLayer {
        get {
            let gradient = GradientLayer()
            switch self {
            case .Clear: //0
                gradient.frame = CGRect.zero
            case .Blue: //1
                gradient.colors = [
                    UIColor(red:0.08, green:0.53, blue:0.8, alpha:1).cgColor,
                    UIColor(red:0.17, green:0.2, blue:0.7, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 1)
            case .Voilet: //2
                gradient.colors = [
                    UIColor(red:0.73, green:0.4, blue:0.83, alpha:1).cgColor,
                    UIColor(red:0.62, green:0.26, blue:0.73, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: 0.5, y: -0.14)
                gradient.endPoint = CGPoint(x: 0.5, y: 1)
            case .LightBlue: //3
                gradient.colors = [
                    UIColor(red:0.17, green:0.6, blue:0.92, alpha:1).cgColor,
                    UIColor(red:0.1, green:0.51, blue:0.82, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: 0.5, y: 0)
                gradient.endPoint = CGPoint(x: 0.5, y: 1)
            case .ReminderYellow: //4
                gradient.colors = [
                    UIColor(red:0.95, green:0.72, blue:0.31, alpha:1).cgColor,
                    UIColor(red:0.93, green:0.45, blue:0.18, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 1)
            case .YHWTokenTopDarkBlue: // 5
                gradient.colors = [
                    UIColor(red:0.18, green:0.62, blue:0.88, alpha:1).cgColor,
                    UIColor(red:0.1, green:0.13, blue:0.62, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1.03, y: 1.07)
            case .YHWTokenMiddleDarkBlue: // 6
                gradient.colors = [
                    UIColor(red:0, green:0.78, blue:1, alpha:1).cgColor,
                    UIColor(red:0, green:0.45, blue:1, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: -0.01, y: 0)
                gradient.endPoint = CGPoint(x: 1, y: 1)
            case .HealthTrackerOrange: // 7
                gradient.colors = [
                    UIColor(red:0.98, green:0.85, blue:0.38, alpha:1).cgColor,
                    UIColor(red:0.97, green:0.42, blue:0.11, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: -0.27, y: -0.06)
                gradient.endPoint = CGPoint(x: 1, y: 0.95)
                
            case .HealthTrackerGreen: // 8
                gradient.colors = [
                    UIColor(red:0.04, green:0.63, blue:0.64, alpha:1).cgColor,
                    UIColor(red:0.1, green:0.85, blue:0.71, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: 1.07, y: 1.16)
                gradient.endPoint = CGPoint(x: 0.35, y: 0)
                
            case .MedicationsPurpule: // 9
                gradient.colors = [
                    UIColor(red:0.73, green:0.4, blue:0.83, alpha:1).cgColor,
                    UIColor(red:0.62, green:0.26, blue:0.73, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: 0.5, y: -0.14)
                gradient.endPoint = CGPoint(x: 0.5, y: 1)
                
            case .FitnessTrackerBlue: // 10
                gradient.colors = [
                    UIColor(red:0.42, green:0.36, blue:0.91, alpha:1).cgColor,
                    UIColor(red:0.14, green:0.09, blue:0.59, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 0.99, y: 1.02)
                
            case .FitnessTrackerWalkOrange: // 11
                gradient.colors = [
                    UIColor(red:1, green:0.84, blue:0.25, alpha:1).cgColor,
                    UIColor(red:0.95, green:0.51, blue:0.51, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: -0.3, y: 0.26)
                gradient.endPoint = CGPoint(x: 1, y: 1)
                
            case .FitnessTrackerRunPink: // 12
                gradient.colors = [
                    UIColor(red:1, green:0.46, blue:0.46, alpha:1).cgColor,
                    UIColor(red:0.96, green:0.31, blue:0.64, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: 1, y: 1)
                gradient.endPoint = CGPoint.zero
                
            case .FitnessTrackerCycleSkye: // 13
                gradient.colors = [
                    UIColor(red:0.09, green:0.92, blue:0.85, alpha:1).cgColor,
                    UIColor(red:0.38, green:0.47, blue:0.92, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: 0.01, y: 0)
                gradient.endPoint = CGPoint(x: 1, y: 1)
                
            case .FitnessTrackerSleepColor: // 14
                gradient.colors = [
                    UIColor(red:0.26, green:0.9, blue:0.58, alpha:1).cgColor,
                    UIColor(red:0.23, green:0.7, blue:0.72, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1, y: 1)
                
            case .ActivityAddGoalColor:// 15
                gradient.colors = [
                    UIColor(red:0.28, green:0.46, blue:0.9, alpha:1).cgColor,
                    UIColor(red:0.56, green:0.33, blue:0.91, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint(x: 1.07, y: 1.16)
                gradient.endPoint = CGPoint(x: 0.31, y: -0.06)
                
            case .FTWeightVoiletColor: // 16
                gradient.colors = [
                    UIColor(red:0.94, green:0.19, blue:0.76, alpha:1).cgColor,
                    UIColor(red:0.38, green:0.58, blue:0.92, alpha:1).cgColor
                ]
                gradient.locations = [0, 1]
                gradient.startPoint = CGPoint.zero
                gradient.endPoint = CGPoint(x: 1.46, y: 1.46)
            }
            return gradient
        }
    }
}



//Bar Color
var color0 = UIColor(red:0.82, green:0.01, blue:0.11, alpha:1)//0
var color1 = UIColor(red:0.96, green:0.65, blue:0.14, alpha:1)//1
var color2 = UIColor(red:0.72, green:0.91, blue:0.53, alpha:1)//2
var color3 = UIColor(red:0.31, green:0.89, blue:0.76, alpha:1)//3
var color4 = UIColor(red:0.49, green:0.83, blue:0.13, alpha:1)//4
var color5 = UIColor(red:0.29, green:0.56, blue:0.89, alpha:1)//5

var color6 = UIColor(red:0.55, green:0.34, blue:0.16, alpha:1)//6
var color7 = UIColor(red:0.67, green:0.97, blue:0.98, alpha:1)//7
var color8 = UIColor(red:0.88, green:0.6, blue:0.98, alpha:1)//8
var color9 = UIColor(red:1, green:0.93, blue:0.59, alpha:1)//9
var color10 = UIColor(red:1, green:0.5, blue:0.58, alpha:1)//10
var color11 = UIColor(red:0.95, green:0.98, blue:0.57, alpha:1)//11

enum ColorBarType : Int32 {
    case Color0 = 0
    case Color1 = 1
    case Color2 = 2
    case Color3 = 3
    case Color4 = 4
    case Color5 = 5
    case Color6 = 6
    case Color7 = 7
    case Color8 = 8
    case Color9 = 9
    case Color10 = 10
    case Color11 = 11
}

extension ColorBarType {
    var value: UIColor {
        get {
            switch self {
            case .Color0: //0
                return color0
            case .Color1: //1
                return color1
            case .Color2: //2
                return color2
            case .Color3: //3
                return color3
            case .Color4: //4
                return color4
            case .Color5: //5
                return color5
            case .Color6: //6
                return color6
            case .Color7: //7
                return color7
            case .Color8: //8
                return color8
            case .Color9: //9
                return color9
            case .Color10: //10
                return color10
            case .Color11: //11
                return color11
            }
        }
    }
}


