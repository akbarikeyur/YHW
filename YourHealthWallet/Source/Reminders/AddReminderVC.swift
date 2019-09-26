//
//  AddReminderVC.swift
//  YourHealthWallet
//
//  Created by Keyur on 21/08/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddReminderVC: UIViewController, HRAChoiceDelegate  {

    @IBOutlet weak var reminderTxt: TextField!
    @IBOutlet weak var reminderTypeLbl: Label!
    @IBOutlet weak var soundLbl: Label!
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var timeLbl: Label!
    
    @IBOutlet weak var lblDaysInterval: Label!
    @IBOutlet weak var lblSpecificDays: Label!
    
    //Content View
    @IBOutlet var selectSpecificDaysContView: View!
    
    //Tableview
    @IBOutlet weak var selectSpecificDaysTblview: HRAChoice!
    
    
    var _selectedReminderType : Int!
    var _selectedSound : Int!
    var selectedDate : Date = Date()
    var selectedTime : Date = Date()
    var selectedInterval = ""
    
    let _arrReminderType:[String] = ["Walk", "Run", "Sleep", "Steps", "Medication", "Doctor visits", "Heart rate check", "BP check", "Blood sugar check", "Medicine reviews"]
    
    let arrRepeat : [String] = [REMINDER.REPEAT.NOT_REPEAT, REMINDER.REPEAT.EVERYDAY, REMINDER.REPEAT.DAYS_INTERVAL, REMINDER.REPEAT.EVERY_WEEK, REMINDER.REPEAT.DAYS_WEEK, REMINDER.REPEAT.EVERY_MONTH, REMINDER.REPEAT.EVERY_YEAR]
    let _arrSound:[String] = ["Default"]
    
    let questionItems = [
        HRAQuestionModel(title: "Sunday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Monday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Tuesday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Wednesday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Thursday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Friday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Saturday", isSelected: false, isUserSelectEnable: true),
        ]
    
    let arrdaysInterval:[String] = ["Every 2 days", "Every 3 days", "Every 4 days", "Every 5 days"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.dateLbl.text = selectedDate.getDateString(DATE_FORMAT.REMINDER_DATE)
        self.timeLbl.text = selectedTime.getDateString(DATE_FORMAT.REMINDER_TIME)
        
        self._selectedReminderType = 0
        self.reminderTypeLbl.text = self._arrReminderType[self._selectedReminderType]
        self._selectedSound = 0
        self.soundLbl.text = self._arrSound[self._selectedSound]
        
        for i in 101...107
        {
            let btn : UIButton = self.view.viewWithTag(i) as! UIButton
            btn.setTitle(arrRepeat[i-101], for: .normal)
        }
        lblSpecificDays.isHidden = true;
        lblDaysInterval.isHidden = true;
        lblSpecificDays.text = ""
        lblDaysInterval.text = ""
    }

    //MARK:- Button Action
    @IBAction func didTapOnCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickToSelectReminderType(_ sender: UIButton) {
        if _selectedReminderType == nil
        {
            _selectedReminderType = 0
        }
        DPPickerManager.shared.showPicker(title: "Select your reminder", selected:_arrReminderType[_selectedReminderType], strings:_arrReminderType) { (value, index, isCancel) in
            if !isCancel {
                self._selectedReminderType = index
                self.reminderTypeLbl.text = self._arrReminderType[self._selectedReminderType]
            }
        }
    }
    
    @IBAction func clickToSelectReminder(_ sender: UIButton) {
        resetReminderBtn()
        sender.isSelected = true
        selectedInterval = (sender.titleLabel?.text)!
        if sender.tag == 103
        {
            lblSpecificDays.isHidden = true;
            lblDaysInterval.isHidden = false
            
            DPPickerManager.shared.showPicker(title: "Set Day Interval", selected:self.arrdaysInterval[0], strings:self.arrdaysInterval) { (value, index, isCancel) in
                if !isCancel {
                    self.lblDaysInterval.text = self.arrdaysInterval[index]
                    self.selectedInterval = self.arrdaysInterval[index]
                }
            }
            
        }
        else if sender.tag == 105
        {
            lblDaysInterval.isHidden = true;
            lblSpecificDays.isHidden = false;
            self.openChoiceofDays()
        }
        else
        {
            lblSpecificDays.isHidden = true;
            lblDaysInterval.isHidden = true;
            lblSpecificDays.text = ""
            lblDaysInterval.text = ""
        }
    }
    
    func resetReminderBtn()
    {
        for i in 101...107
        {
            let btn : UIButton = self.view.viewWithTag(i) as! UIButton
            btn.isSelected = false
        }
    }
    
    func openChoiceofDays() {
        setHRAChoice()
        DPPickerManager.shared.showPicker(title: "Select specific days", view: selectSpecificDaysContView) { (isCancel) in
        }
    }
    
    //Selected specific days
    func setHRAChoice()
    {
        selectSpecificDaysTblview.isRightToLeft = false
        
        selectSpecificDaysTblview.delegate = self
        
        selectSpecificDaysTblview.data = questionItems
        
        selectSpecificDaysTblview.selectionType = .multiple
        selectSpecificDaysTblview.cellHeight = 60
        
        selectSpecificDaysTblview.selectedImage = UIImage(named: "check-selected")
        selectSpecificDaysTblview.unselectedImage = UIImage(named: "check-empty")
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let selectedItemCommaSeparated = selectSpecificDaysTblview.getSelectedItemsJoined(separator: ",")
        
        self.lblSpecificDays.text = selectedItemCommaSeparated
        selectedInterval = self.lblSpecificDays.text!
        lblSpecificDays.isHidden = false;
    }
    
    @IBAction func clickToSelectSound(_ sender: Any) {
        if _selectedSound == nil
        {
            _selectedSound = 0
        }
        DPPickerManager.shared.showPicker(title: "Select reminder notification sound", selected:_arrSound[_selectedSound], strings:_arrSound) { (value, index, isCancel) in
            if !isCancel {
                self._selectedSound = index
                self.soundLbl.text = self._arrSound[self._selectedSound]
            }
        }
    }
    
    @IBAction func clickToSelectDate(_ sender: UIButton) {
        if selectedDate == nil
        {
            selectedDate = Date()
        }
        let minDate : Date = Date()
        DPPickerManager.shared.showPicker(title: "Select Date", selected: selectedDate, min: minDate, max: nil) { (date, isCancel) in
            if !isCancel && date != nil {
                self.selectedDate = date!
                self.dateLbl.text = date!.getDateString(DATE_FORMAT.REMINDER_DATE)
            }
        }
    }
    
    @IBAction func clickToSelectTime(_ sender: UIButton) {
        if selectedTime == nil
        {
            selectedTime = Date()
        }
        DPPickerManager.shared.showPicker(title: "Select Time", selected: selectedTime) { (date, isCancel) in
            if !isCancel && date != nil {
                self.selectedTime = date!
                self.timeLbl.text = date!.getDateString(DATE_FORMAT.REMINDER_TIME)
            }
        }
    }
    
    @IBAction func clickToAddReminder(_ sender: Any) {
        
        if reminderTxt.text?.trimmed == "" && reminderTypeLbl.text == ""  {
            displayToast("Please add your reminder")
        }
        else if selectedInterval == ""
        {
            displayToast("Please select reminder interval")
        }
        else
        {
            var param : [String : Any] = [String : Any]()
            if reminderTxt.text != "" {
                param[AddReminderRequestKey.kReminderType] = reminderTxt.text
            }else{
                param[AddReminderRequestKey.kReminderType] = reminderTypeLbl.text
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DATE_FORMAT.REMINDER_SERVER_DATE
            param[AddReminderRequestKey.kReminderStartDate] = dateFormatter.string(from: combineDateWithTime(date: selectedDate, time: selectedTime))
            param[AddReminderRequestKey.kReminderInterval] = selectedInterval
            param[AddReminderRequestKey.kUserId] = AppUserDefaults.getUserID()
            
            SVProgressHUD.show()
            RemindersService.CreateReminder(param) { (data) in
                SVProgressHUD.dismiss()
                NotificationCenter.default.post(name: NSNotification.Name.init("NOTIFICATION_UPDATE_REMINDER"), object: data)
                self.didTapOnCloseButton(self)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
