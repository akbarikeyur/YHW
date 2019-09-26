//
//  Utility.swift
//  YourHealthWallet
//
//  Created by Keyur on 29/08/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import Foundation
import Toast
import SVProgressHUD

func combineDateWithTime(date: Date, time: Date) -> Date {
    let calendar = Calendar.current
    
    let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
    let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
    
    var mergedComponments = DateComponents()
    mergedComponments.year = dateComponents.year!
    mergedComponments.month = dateComponents.month!
    mergedComponments.day = dateComponents.day!
    mergedComponments.hour = timeComponents.hour!
    mergedComponments.minute = timeComponents.minute!
    mergedComponments.second = timeComponents.second!
    
    if let finalDate : Date = calendar.date(from: mergedComponments)
    {
        return finalDate
    }
    return date
}



func displayToast(_ message : String)
{
    AppDelegate.mainWindow().makeToast(message)
}

func showProgress()
{
    SVProgressHUD.show()
}

func hideProgress()
{
    SVProgressHUD.dismiss()
}

extension Date {

    var weekdayName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "E"
        return formatter.string(from: self as Date)
    }
    
    var weekdayNameFull: String {
        let formatter = DateFormatter(); formatter.dateFormat = "EEEE"
        return formatter.string(from: self as Date)
    }
    var monthName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "MMM"
        return formatter.string(from: self as Date)
    }
    var OnlyYear: String {
        let formatter = DateFormatter(); formatter.dateFormat = "YYYY"
        return formatter.string(from: self as Date)
    }
    var period: String {
        let formatter = DateFormatter(); formatter.dateFormat = "a"
        return formatter.string(from: self as Date)
    }
    var timeOnly: String {
        let formatter = DateFormatter(); formatter.dateFormat = "hh : mm"
        return formatter.string(from: self as Date)
    }
    var timeWithPeriod: String {
        let formatter = DateFormatter(); formatter.dateFormat = "hh : mm a"
        return formatter.string(from: self as Date)
    }
    
    var DatewithMonth: String {
        let formatter = DateFormatter(); formatter.dateStyle = .medium ;        return formatter.string(from: self as Date)
    }
}
