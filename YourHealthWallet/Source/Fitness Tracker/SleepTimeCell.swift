//
//  SleepTimeCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/20/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import HealthKit

class SleepTimeCell: UITableViewCell {

    @IBOutlet weak var lblBedTime: Label!
    @IBOutlet weak var lblWakupTime: Label!
    @IBOutlet weak var lblAverage: Label!
    
    @IBOutlet weak var lblBedTimeFormate: Label!
    @IBOutlet weak var lblWakupTimeFormate: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
    }
    
    func setCalculateSleepData(firstCellWorkouts:[HKSample]?){
        
        if let workouts = firstCellWorkouts{
            guard let myRecentSample = workouts.first else {
                print("error")
                return
            }
            
            let myGoBedTime = myRecentSample.startDate
            let myWeakUpTime = myRecentSample.endDate
            let mySleepTime = myWeakUpTime.timeIntervalSince(myGoBedTime)
            
            DispatchQueue.main.async {
                self.lblBedTime.text = myRecentSample.startDate.toString(format: .custom(DATE_FORMAT.SLEEP_BEDANDWAKEUPTIME))
                self.lblBedTimeFormate.text = myRecentSample.startDate.toString(format: .custom(DATE_FORMAT.SLEEP_TIMEFORMATE))
                
                self.lblWakupTime.text = myRecentSample.endDate.toString(format: .custom(DATE_FORMAT.SLEEP_BEDANDWAKEUPTIME))
                self.lblWakupTimeFormate.text = myRecentSample.endDate.toString(format: .custom(DATE_FORMAT.SLEEP_TIMEFORMATE))
                
                let hour = getHourFromInteval(interval: mySleepTime)
                let min = getMinutesFromInteval(interval: mySleepTime)
                self.lblAverage.text = ("\(hour)h:\(min)m")
                
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
