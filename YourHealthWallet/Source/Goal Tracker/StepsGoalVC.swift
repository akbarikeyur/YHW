//
//  StepsGoalVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/12/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class StepsGoalVC: ViewController {
    
    @IBOutlet weak var selectedPeriodLbl: Label!
    @IBOutlet weak var selectedStepsLbl: Label!
    var objStepsGoal: AddStepsGoalInfo?
    
    let _periods:[String] = ["Daily", "Weekly", "Monthly"]
    let _steps:[String] = ["1000", "2000", "5000","10000","15000"]
    
    var _selectedPeriod:Int!
    var _selectedSteps:Int!
    
    var strActivity:String?
    var stepCount:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _selectedPeriod = 0
        _selectedSteps = 0
        
        if AppUserDefaults.isAddedStepsGoal(){
            
            guard objStepsGoal != nil else{
                return
            }
            _selectedPeriod = _periods.index(of: (objStepsGoal?.Addstepsfreq)!)
            if let range = objStepsGoal?.Willwalk.range(of: " Steps") {
                objStepsGoal?.Willwalk.removeSubrange(range)
            }
            _selectedSteps = _steps.index(of: (objStepsGoal?.Willwalk)!)
            strActivity = objStepsGoal?.Addstepsfreq
            stepCount = objStepsGoal?.Willwalk
            selectedPeriodLbl.text = objStepsGoal?.Addstepsfreq
            selectedStepsLbl.text = objStepsGoal?.Willwalk
        }
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Button Tap
    @IBAction func onSelectPeriodBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Period", selected: _periods[_selectedPeriod], strings:_periods) { (value, index, isCancel) in
            if !isCancel {
                self._selectedPeriod = index
                self.strActivity = value
                self.selectedPeriodLbl.text = self._periods[self._selectedPeriod]
            }
        }
    }
    
    //MARK:- Button Tap
    @IBAction func onSelectStepsBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Steps", selected: _steps[_selectedSteps], strings:_steps) { (value, index, isCancel) in
            if !isCancel {
                self._selectedSteps = index
                self.stepCount = value
                self.selectedStepsLbl.text = self._steps[self._selectedSteps] + " Steps"
                
            }
        }
    }
    
    
    @IBAction func saveGoalButton(_ sender: Button) {
        if isValidData() {
            if AppUserDefaults.isAddedStepsGoal(){
                self.stepsGoalEditedAPI()
            }else{
                self.stepsGoalAPI()
            }
        }
        
    }
    
    func stepsGoalAPI()
    {
        //Request parameters
        let param:Parameters = [AddStepsGoalRequestKey.kWillWalk:self.selectedStepsLbl.text ?? "",
                                AddStepsGoalRequestKey.kStepsfreq:self.strActivity ?? "",
                                kUserId:AppUserDefaults.getUserID()];
        
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForAddStepsGoal(url: AddStepsGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .post, params: param, complitionHandler: {(Info, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            AppDelegate.mainWindow().makeToast(kSuccessAddGoal)
            AppUserDefaults.setAddedStepsGoal(true)
            self.navigationController?.popViewController(animated: true)
            
        })
    }
    
    func stepsGoalEditedAPI()
    {
        //Request parameters
        let param:Parameters = [AddStepsGoalRequestKey.kWillWalk:self.selectedStepsLbl.text ?? "",
                                AddStepsGoalRequestKey.kStepsfreq:self.strActivity ?? "",
                                "id":objStepsGoal?.id ?? "",
                                kUserId:AppUserDefaults.getUserID()];
        
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForAddStepsGoal(url: AddStepsGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .put, params: param, complitionHandler: {(Info, error) in
            
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
        
        guard (self.stepCount != nil) else {
            AppDelegate.mainWindow().makeToast(kSelectSteps)
            return false
        }
        
        guard (self.strActivity != nil) else {
            AppDelegate.mainWindow().makeToast(kSelectActivity)
            return false
        }
        return true
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
