//
//  AddSleepVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 8/25/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import HealthKit
import SVProgressHUD

class AddSleepVC: UIViewController {
    
    @IBOutlet weak var startDateBtn: Button!
    @IBOutlet weak var endDateBtn: Button!
    @IBOutlet weak var startTimeBtn: Button!
    @IBOutlet weak var endTimeBtn: Button!
    
    var sleepType:Int?
    
    var startSelectedDate:Date = Date()
    var endSelectedDate:Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.startDateBtn.setTitle(startSelectedDate.toString(format: .custom(DATE_FORMAT.DISP_DATE)), for: .normal)
        self.startTimeBtn.setTitle(startSelectedDate.toString(format: .custom(DATE_FORMAT.MEDICATION_TIME)), for: .normal)
        
        self.endDateBtn.setTitle(endSelectedDate.toString(format: .custom(DATE_FORMAT.DISP_DATE)), for: .normal)
        self.endTimeBtn.setTitle(endSelectedDate.toString(format: .custom(DATE_FORMAT.MEDICATION_TIME)), for: .normal)
        
        sleepType = HKCategoryValueSleepAnalysis.inBed.rawValue
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Button Action
    @IBAction func didTapOnCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSleepTypeSelection(_ sender: Any) {
        let senderBtn = sender as? UIButton
        var index: Int = 1301
        while (self.view.viewWithTag(index) != nil) {
            let button = self.view.viewWithTag(index) as? UIButton
            if senderBtn?.isEqual(button) ?? false {
                button?.isSelected = true
                if index == 1301{
                    sleepType = HKCategoryValueSleepAnalysis.inBed.rawValue
                    
                }else{
                    sleepType = HKCategoryValueSleepAnalysis.asleep.rawValue
                    
                }
            }
            else {
                button?.isSelected = false
            }
            index += 1
        }
    }
    
    @IBAction func clickToSelectStartDate(_ sender: UIButton) {
        
        DPPickerManager.shared.showPickerDateAndTime(title: "Select Start-Time", selected: startSelectedDate, min: nil, max: nil) { (date, isCancel) in
            if !isCancel && date != nil {
                self.startDateBtn.setTitle(date!.toString(format: .custom(DATE_FORMAT.DISP_DATE)), for: .normal)
                self.startTimeBtn.setTitle(date!.toString(format: .custom(DATE_FORMAT.MEDICATION_TIME)), for: .normal)
                
                self.startSelectedDate = date!
            }
        }
        
    }
    
    @IBAction func clickToSelectEndDate(_ sender: UIButton) {
        
        DPPickerManager.shared.showPickerDateAndTime(title: "Select End-Time", selected: endSelectedDate, min: nil, max: nil) { (date, isCancel) in
            if !isCancel && date != nil {
                self.endDateBtn.setTitle(date!.toString(format: .custom(DATE_FORMAT.DISP_DATE)), for: .normal)
                self.endTimeBtn.setTitle(date!.toString(format: .custom(DATE_FORMAT.MEDICATION_TIME)), for: .normal)
                
                self.endSelectedDate = date!
            }
        }
        
    }
    
    @IBAction func saveSleepAnalyis(_ sender: UIButton) {
        
        if isValidData(){
            
            SVProgressHUD.show()
            HealthManagerKit.Shared.saveSleepAnalysis(categorySleepValue: sleepType!, startTime: self.startSelectedDate, endTime: self.endSelectedDate) { (success, error) in
                if success{
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        AppDelegate.mainWindow().makeToast(kEnterAddedSleep)
                    }
                }
                else{
                    SVProgressHUD.dismiss()
                    AppDelegate.mainWindow().makeToast(error?.localizedDescription)
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    // MARK: - Validation Check
    private func isValidData() -> Bool {
        
        if self.startSelectedDate > self.endSelectedDate{
            AppDelegate.mainWindow().makeToast(kEnterDateValidation)
            return false
            
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
