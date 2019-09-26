//
//  AddActivityWalkVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 8/22/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddActivityWalkRunCycleVC: ViewController {

    @IBOutlet weak var titleLbl: Button!

    @IBOutlet weak var hrText: TextField!
    @IBOutlet weak var minText: TextField!
    @IBOutlet weak var secText: TextField!
    
    @IBOutlet weak var dateBtn: Button!
    @IBOutlet weak var timeBtn: Button!

    @IBOutlet weak var txtCalories: TextField!
    @IBOutlet weak var txtSteps: TextField!
    @IBOutlet weak var txtKilometers: TextField!

    var activityType: AddActivityType!
    
    var selectedDate:Date = Date()
    var selectedTime:Date = Date()
    var endDate:Date?
    
    let arrHours = Array(0...23)
    let arrMinutes = Array(0...59)
    let arrSeconds = Array(0...59)
    
    let numberOfComponents = 6
    var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedDate.compare(.isToday){
            dateBtn.setTitle("Today", for: .normal)
        }
        
        self.timeBtn.setTitle(selectedDate.toString(format: .custom(DATE_FORMAT.MEDICATION_TIME)), for: .normal)

        switch activityType.hashValue {
        case 0:
            self.titleLbl.setTitle("Add Activity - Walk", for: .normal)
        case 1:
            self.titleLbl.setTitle("Add Activity - Run", for: .normal)
        case 2:
            self.titleLbl.setTitle("Add Activity - Cycle", for: .normal)
        default:
            print("")
        }
        
        
        
        self.setUpPickerView()
        // Do any additional setup after loading the view.
    }

    func setUpPickerView()
    {
        self.pickerView = UIPickerView()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        hrText.inputView = self.pickerView
        minText.inputView = self.pickerView
        secText.inputView = self.pickerView
    }
    
    //MARK:- Button Action
    @IBAction func didTapOnCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func clickToSelectDateAndTime(_ sender: UIButton) {
       
        DPPickerManager.shared.showPickerDateAndTime(title: "Select Date & Time", selected: selectedDate, min: nil, max: nil) { (date, isCancel) in
            if !isCancel && date != nil {
                if (date?.compare(.isToday))!{
                    self.dateBtn.setTitle("Today", for: .normal)
                }else if(date?.compare(.isYesterday))!{
                    self.dateBtn.setTitle("Yesterday", for: .normal)
                }else if(date?.compare(.isTomorrow))!{
                    self.dateBtn.setTitle("Tomorrow", for: .normal)
                }else{
                    self.dateBtn.setTitle(date!.toString(format: .custom(DATE_FORMAT.DISP_DATE)), for: .normal)
                }
                self.timeBtn.setTitle(date!.toString(format: .custom(DATE_FORMAT.MEDICATION_TIME)), for: .normal)
                self.selectedDate = date!
            }
        }
        
    }
    
    @IBAction func didTapOnSaveButton(_ sender: Any) {
        
        if isValidData(){
            
            let myCalories = (self.txtCalories.text! as NSString).doubleValue
            let mySteps = (self.txtSteps.text! as NSString).doubleValue
            let myKilometers = (self.txtKilometers.text! as NSString).doubleValue
            
            SVProgressHUD.show()
            switch activityType.hashValue {
            case 0:
                HealthManagerKit.Shared.saveWorkout(workoutType: .walking, workoutStartDate: self.selectedDate, workoutEndDate: self.endDate!, workoutDuration: (self.endDate?.timeIntervalSince(self.selectedDate))!, workoutEnergyBurned: myCalories, workoutTotalDistance: myKilometers,workoutSteps:mySteps) { (success, error) in
                    if success{
                        SVProgressHUD.dismiss()
                        AppDelegate.mainWindow().makeToast(kEnterAddedWalk)
                    }
                    else{
                        SVProgressHUD.dismiss()
                        AppDelegate.mainWindow().makeToast(error?.localizedDescription)
                    }
                    self.dismiss(animated: true, completion: nil)

                }
                break
            case 1:
                HealthManagerKit.Shared.saveWorkout(workoutType: .running, workoutStartDate: self.selectedDate, workoutEndDate: self.endDate!, workoutDuration: (self.endDate?.timeIntervalSince(self.selectedDate))!, workoutEnergyBurned: myCalories, workoutTotalDistance: myKilometers,workoutSteps:mySteps) { (success, error) in
                    if success{
                        SVProgressHUD.dismiss()
                        AppDelegate.mainWindow().makeToast(kEnterAddedRun)
                    }
                    else{
                        SVProgressHUD.dismiss()
                        AppDelegate.mainWindow().makeToast(error?.localizedDescription)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
                break
            case 2:
                HealthManagerKit.Shared.saveWorkout(workoutType: .cycling, workoutStartDate: self.selectedDate, workoutEndDate: self.endDate!, workoutDuration: (self.endDate?.timeIntervalSince(self.selectedDate))!, workoutEnergyBurned: myCalories, workoutTotalDistance: myKilometers,workoutSteps:mySteps) { (success, error) in
                    if success{
                        SVProgressHUD.dismiss()
                        AppDelegate.mainWindow().makeToast(kEnterAddedCycle)
                    }
                    else{
                        SVProgressHUD.dismiss()
                        AppDelegate.mainWindow().makeToast(error?.localizedDescription)
                    }
                    self.dismiss(animated: true, completion: nil)
                }
                break
            default:
                print("")
            }
        }
    }
    
    // MARK: - Validation Check
    private func isValidData() -> Bool {
        
        if(hrText.text == ""){
            AppDelegate.mainWindow().makeToast(kEnterAddActiveTime)
            return false
        }
        if(self.txtCalories.text?.isEmpty)!{
            AppDelegate.mainWindow().makeToast(kEnterCalories)
            return false
        }
        if(self.txtSteps.text?.isEmpty)!{
            AppDelegate.mainWindow().makeToast(kEnterSteps)
            return false
        }
        if(self.txtKilometers.text?.isEmpty)!{
            AppDelegate.mainWindow().makeToast(kEnterKilometer)
            return false
        }
        return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UIPickerView Methods
extension AddActivityWalkRunCycleVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return arrHours.count
        }else if component == 2 {
            return arrMinutes.count
        }else if component == 4 {
            return arrSeconds.count
        }else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(arrHours[row])"
        }else if component == 1 {
            return "Hrs"
        }else if component == 2 {
            return "\(arrMinutes[row])"
        }else if component == 3 {
            return "Min"
        }else if component == 4 {
            return "\(arrSeconds[row])"
        }else {
            return "Sec"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hrIndex = pickerView.selectedRow(inComponent: 0)
        let minIndex = pickerView.selectedRow(inComponent: 2)
        let secondIndex = pickerView.selectedRow(inComponent: 4)
        
        self.hrText.text = "\(arrHours[hrIndex])"
        self.minText.text = " \(arrMinutes[minIndex])"
        self.secText.text = " \(arrSeconds[secondIndex])"
        
        self.endDate = selectedDate.plusHoursMinutesSeconds(hours: UInt(arrHours[hrIndex]), minutes: UInt(arrMinutes[minIndex]), seconds: UInt(arrSeconds[secondIndex]))
    }
}

