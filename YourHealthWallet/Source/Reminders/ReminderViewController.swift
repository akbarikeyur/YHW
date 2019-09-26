//
//  ReminderViewController.swift
//  YourHealthWallet
//
//  Created by Shridhar on 2/3/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import SVProgressHUD

class ReminderViewController: ViewController {
    
    @IBOutlet weak var profilePicImgView: ImageView!
    @IBOutlet weak var buttonMonthYear: Button!
    @IBOutlet weak var dateCollectionView: RemindersDateCollectionView!
    @IBOutlet weak var remindersCollectionView: RemindersCollectionView!
    
    var arrReminderData : [AddReminderInfo] = [AddReminderInfo]()
    var reminderTimer : Timer!
    
    var selectedDate: Date! {
        didSet {
            let formater = DateFormatter()
            formater.dateFormat = "MMMM yyyy"
            let monthAndYear = formater.string(from: selectedDate)
            self.buttonMonthYear.setTitle(monthAndYear, for: .normal)
        }
    }
    
    init() {
        super.init(nibName: "ReminderViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateReminderData(noti:)), name: NSNotification.Name.init("NOTIFICATION_UPDATE_REMINDER"), object: nil)
        selectedDate = Date()
        dateCollectionView.startDate = selectedDate
        dateCollectionView.didChangeDate = { (newDate) in
            
            if self.reminderTimer != nil
            {
                self.reminderTimer.invalidate()
            }
            self.reminderTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.setDataInList), userInfo: nil, repeats: false)
            self.selectedDate = newDate
        }
        
        
        getReminderData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateReminderData(noti : Notification)
    {
        if let dict : AddReminderInfo = noti.object as? AddReminderInfo
        {
            arrReminderData.append(dict)
            setDataInList()
        }
    }
    
    func getReminderData()
    {
        SVProgressHUD.show()
        RemindersService.callWSForGetReminders(url: GetRemindersUrl + "/" + AppUserDefaults.getUserID() + "/getalluserreminders", httpMethod: .get, complitionHandler: { (reminderLists, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            
            guard reminderLists != nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            self.arrReminderData = (reminderLists?.data)!
            self.setDataInList()
        })
    }
    
    @objc func setDataInList()
    {
        var arrSelectedReminder : [AddReminderInfo] = [AddReminderInfo]()
        
        for reminder in arrReminderData
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DATE_FORMAT.REMINDER_SERVER_DATE
            let reminderDate : Date = dateFormatter.date(from: reminder.reminderstartdate)!
            
            if (reminder.repeatinterval.contains("Sunday") || reminder.repeatinterval.contains("Monday") || reminder.repeatinterval.contains("Tuesday") || reminder.repeatinterval.contains("Wednesday") || reminder.repeatinterval.contains("Thursday") || reminder.repeatinterval.contains("Friday") || reminder.repeatinterval.contains("Saturday"))
            {
                let arrDays : [String] = reminder.repeatinterval.components(separatedBy: ",")
                
                if arrDays.contains(selectedDate.weekdayNameFull)
                {
                    arrSelectedReminder.append(reminder)
                }
            }
            else
            {
                switch reminder.repeatinterval {
                case REMINDER.REPEAT.NOT_REPEAT:
                    if converToDateOnlyFromDate(date: reminderDate) == converToDateOnlyFromDate(date: selectedDate)
                    {
                        arrSelectedReminder.append(reminder)
                    }
                    break
                case REMINDER.REPEAT.EVERYDAY:
                    if converToDateOnlyFromDate(date: reminderDate) <= converToDateOnlyFromDate(date: selectedDate)
                    {
                        arrSelectedReminder.append(reminder)
                    }
                    break
                case REMINDER.REPEAT.TWO_DAYS_INTERVAL:
                    if converToDateOnlyFromDate(date: reminderDate) <= converToDateOnlyFromDate(date: selectedDate) && (getDaysInterval(reminderDate: reminderDate, selectedDate: selectedDate) % 2 == 0)
                    {
                        arrSelectedReminder.append(reminder)
                    }
                    break
                case REMINDER.REPEAT.THREE_DAYS_INTERVAL:
                    if converToDateOnlyFromDate(date: reminderDate) <= converToDateOnlyFromDate(date: selectedDate) && (getDaysInterval(reminderDate: reminderDate, selectedDate: selectedDate) % 3 == 0)
                    {
                        arrSelectedReminder.append(reminder)
                    }
                    break
                case REMINDER.REPEAT.FOUR_DAYS_INTERVAL:
                    if converToDateOnlyFromDate(date: reminderDate) <= converToDateOnlyFromDate(date: selectedDate) && (getDaysInterval(reminderDate: reminderDate, selectedDate: selectedDate) % 4 == 0)
                    {
                        arrSelectedReminder.append(reminder)
                    }
                    break
                case REMINDER.REPEAT.FIVE_DAYS_INTERVAL:
                    if converToDateOnlyFromDate(date: reminderDate) <= converToDateOnlyFromDate(date: selectedDate) && (getDaysInterval(reminderDate: reminderDate, selectedDate: selectedDate) % 5 == 0)
                    {
                        arrSelectedReminder.append(reminder)
                    }
                    break
                case REMINDER.REPEAT.EVERY_WEEK:
                    if converToDateOnlyFromDate(date: reminderDate) <= converToDateOnlyFromDate(date: selectedDate) && (getDaysInterval(reminderDate: reminderDate, selectedDate: selectedDate) % 7 == 0)
                    {
                        arrSelectedReminder.append(reminder)
                    }
                    break
                case REMINDER.REPEAT.DAYS_WEEK:
                    
                    break
                case REMINDER.REPEAT.EVERY_MONTH:
                    if converToDateOnlyFromDate(date: reminderDate) <= converToDateOnlyFromDate(date: selectedDate) && isSameDay(reminderDate: reminderDate, selectedDate: selectedDate)
                    {
                        arrSelectedReminder.append(reminder)
                    }
                    break
                case REMINDER.REPEAT.EVERY_YEAR:
                    if converToDateOnlyFromDate(date: reminderDate) <= converToDateOnlyFromDate(date: selectedDate) && isSameDayAndMonth(reminderDate: reminderDate, selectedDate: selectedDate)
                    {
                        arrSelectedReminder.append(reminder)
                    }
                    break
                    
                default:
                    break
                }
            }
        }
        
        remindersCollectionView.reminders = arrSelectedReminder
        remindersCollectionView.reloadData()
    }
    
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated:
            true)
    }
    
    @IBAction func didTapOnMonthYearButton(_ sender: Button) {
        let min = Date()
        let max = min.addingTimeInterval(31536000) // 1 year
        DPPickerManager.shared.showPicker(title: "Date Picker", selected: selectedDate, min: min, max: max) { (date, cancel) in
            if !cancel {
                self.selectedDate = date
                self.dateCollectionView.startDate = self.selectedDate
            }
        }
        
    }
    
    @IBAction func didTapOnAdd(_ sender: Button) {
        let addVC = AddReminderVC()
        self.navigationController?.present(addVC, animated: true)
    }
    
    func converToDateOnlyFromDate(date : Date) -> Date
    {
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        var mergedComponments = DateComponents()
        mergedComponments.year = dateComponents.year!
        mergedComponments.month = dateComponents.month!
        mergedComponments.day = dateComponents.day!
        
        if let finalDate : Date = calendar.date(from: mergedComponments)
        {
            return finalDate
        }
        return date
    }
    
    func getDaysInterval(reminderDate : Date, selectedDate : Date) -> Int
    {
        let calendar = Calendar.current
        let dateComponents1 = calendar.dateComponents([.year, .month, .day], from: reminderDate)
        let dateComponents2 = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        return (dateComponents2.day! - dateComponents1.day!)
    }
    
    func isSameDay(reminderDate : Date, selectedDate : Date) -> Bool
    {
        let calendar = Calendar.current
        let dateComponents1 = calendar.dateComponents([.year, .month, .day], from: reminderDate)
        let dateComponents2 = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        return (dateComponents1.day! == dateComponents2.day!)
    }
    
    func isSameDayAndMonth(reminderDate : Date, selectedDate : Date) -> Bool
    {
        let calendar = Calendar.current
        let dateComponents1 = calendar.dateComponents([.year, .month, .day], from: reminderDate)
        let dateComponents2 = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        return ((dateComponents1.day! == dateComponents2.day!) && (dateComponents1.month! == dateComponents2.month!))
    }
}
