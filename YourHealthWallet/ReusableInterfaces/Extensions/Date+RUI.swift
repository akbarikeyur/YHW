//
//  Date+RUI.swift
//  YourHealthWallet
//
//  Created by Amisha on 3/3/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

extension Date {
    
    func getDateString(_ format:String) -> String{
        let dateFormmat = DateFormatter()
        dateFormmat.dateFormat = format
        return dateFormmat.string(from: self)
    }
    
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value:7, to: sunday)
    }
}
