//
//  CustomGoalVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/15/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class CustomGoalVC: ViewController {
    
    @IBOutlet weak var selectedPeriodLbl: Label!
    @IBOutlet weak var selectedStepsLbl: Label!
    @IBOutlet weak var selectedActLbl: Label!
    var objCustomGoal: AddCustomGoalInfo?
    
    let _periods:[String] = ["Daily", "Weekly", "Monthly"]
    let _steps:[String] = ["100", "200", "300","400"]
    let _activities:[String] = ["Walking", "Sleep", "Running","Steps"]
    
    var _selectedPeriod:Int!
    var _selectedSteps:Int!
    var _selectedAct:Int!
    
    var strActivity:String?
    var stepCount:Int?
    var strPeriod:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _selectedPeriod = 0
        _selectedSteps = 0
        _selectedAct = 0
        
        if AppUserDefaults.isAddedCustomGoal(){
            
            guard objCustomGoal != nil else{
                return
            }
            _selectedPeriod = _periods.index(of: (objCustomGoal?.activityfreq)!)
            _selectedSteps = _steps.index(of: String((objCustomGoal?.calories)!))
            _selectedAct = _activities.index(of: (objCustomGoal?.activityname)!)
            
            selectedPeriodLbl.text = _periods[_selectedPeriod]
            selectedStepsLbl.text = _steps[_selectedSteps]
            selectedActLbl.text = _activities[_selectedAct]
        }
    }
    
    //MARK:- Button Tap
    @IBAction func onSelectPeriodBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Period", selected: _periods[_selectedPeriod], strings:_periods) { (value, index, isCancel) in
            if !isCancel {
                self._selectedPeriod = index
                self.strPeriod = value
                self.selectedPeriodLbl.text = self._periods[self._selectedPeriod]
                
            }
        }
    }
    
    //MARK:- Button Tap
    @IBAction func onSelectStepsBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Calories", selected: _steps[_selectedSteps], strings:_steps) { (value, index, isCancel) in
            if !isCancel {
                self._selectedSteps = index
                self.stepCount = Int(value!)
                self.selectedStepsLbl.text = self._steps[self._selectedSteps] + " calories"
                
            }
        }
    }
    
    //MARK:- Button Tap
    @IBAction func onSelectActBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Activity", selected: _activities[_selectedAct], strings:_activities) { (value, index, isCancel) in
            if !isCancel {
                self._selectedAct = index
                self.strActivity = value
                self.selectedActLbl.text = self._activities[self._selectedAct]
            }
        }
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveGoalButton(_ sender: Button) {
        
        if isValidData() {
            if AppUserDefaults.isAddedCustomGoal(){
                self.editCustomGoalAPI()
            }else{
                self.addGoalAPI()
            }
        }
    }
    
    func addGoalAPI()
    {
        //Request parameters
        let param:Parameters = [AddCustomGoalRequestKey.kActivityname:self.strActivity!,
                                AddCustomGoalRequestKey.kCalories:stepCount!,
                                AddCustomGoalRequestKey.kActivityfreq:self.strPeriod!,
                                kUserId:AppUserDefaults.getUserID()];
        
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForAddCustomGoal(url: AddCustomGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .post, params: param, complitionHandler: { (Info, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            AppDelegate.mainWindow().makeToast(kSuccessAddGoal)
            AppUserDefaults.setAddedCustomGoal(true)
            self.navigationController?.popViewController(animated: true)
            
        })
    }
    
    func editCustomGoalAPI()
    {
        //Request parameters
        let param:Parameters = [AddCustomGoalRequestKey.kActivityname:self.strActivity!,
                                AddCustomGoalRequestKey.kCalories:stepCount!,
                                AddCustomGoalRequestKey.kActivityfreq:self.strPeriod!,
                                "id":objCustomGoal?.id ?? "",
                                kUserId:AppUserDefaults.getUserID()];
        
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForAddCustomGoal(url: AddCustomGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .put, params: param, complitionHandler: { (Info, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            AppDelegate.mainWindow().makeToast(kSuccessEditedGoal)
            self.navigationController?.popViewController(animated: true)
            
        })
    }
    
    //MARK:- Validation
    private func isValidData() -> Bool {
        
        guard (strActivity != nil) else {
            AppDelegate.mainWindow().makeToast(kSelectActivity)
            return false
        }
        
        guard (stepCount != nil) else {
            AppDelegate.mainWindow().makeToast(kSelectSteps)
            return false
        }
        
        guard (strPeriod != nil) else {
            AppDelegate.mainWindow().makeToast(kSelectPeriod)
            return false
        }
        return true
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
