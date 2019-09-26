//
//  CaloriesGoalVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 8/5/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class CaloriesGoalVC: UIViewController {
    
    @IBOutlet weak var selectedPeriodLbl: Label!
    @IBOutlet weak var selectedStepsLbl: Label!
    var objCaloriesGoal: AddCaloriesGoalInfo?
    
    let _periods:[String] = ["Daily", "Weekly", "Monthly"]
    let _steps:[String] = ["1000", "2000", "5000","10000","15000","20000"]
    
    var _selectedPeriod:Int!
    var _selectedSteps:Int!
    
    var strActivity:String?
    var stepCount:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _selectedPeriod = 0
        _selectedSteps = 0
        
        if AppUserDefaults.isAddedCaloriesGoal(){
            
            guard objCaloriesGoal != nil else{
                return
            }
            _selectedSteps = _periods.index(of: (objCaloriesGoal?.burncalories)!)
            if let range = objCaloriesGoal?.burncalories.range(of: " Calories") {
                objCaloriesGoal?.burncalories.removeSubrange(range)
            }
            _selectedPeriod = _steps.index(of: (objCaloriesGoal?.burnfreq)!)
            strActivity = objCaloriesGoal?.burnfreq
            stepCount = objCaloriesGoal?.burncalories
            selectedPeriodLbl.text = objCaloriesGoal?.burnfreq
            selectedStepsLbl.text = objCaloriesGoal?.burncalories
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
        DPPickerManager.shared.showPicker(title: "Select Calories", selected: _steps[_selectedSteps], strings:_steps) { (value, index, isCancel) in
            if !isCancel {
                self._selectedSteps = index
                self.stepCount = value
                self.selectedStepsLbl.text = self._steps[self._selectedSteps] + " Calories"
                
            }
        }
    }
    
    
    @IBAction func saveGoalButton(_ sender: Button) {
        if isValidData() {
            if AppUserDefaults.isAddedCaloriesGoal(){
                self.caloriesGoalEditedAPI()
            }else{
                self.caloriesGoalAPI()
            }
        }
        
    }
    
    func caloriesGoalAPI()
    {
        //Request parameters
        let param:Parameters = [AddCaloriesGoalRequestKey.kBurnCalories:self.selectedStepsLbl.text ?? "",
                                AddCaloriesGoalRequestKey.kBurnFreq:self.strActivity ?? "",
                                kUserId:AppUserDefaults.getUserID()];
        
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForAddCaloriesGoal(url: AddCaloriesGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .post, params: param, complitionHandler: {(Info, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            AppDelegate.mainWindow().makeToast(kSuccessAddGoal)
            AppUserDefaults.setAddedCaloriesGoal(true)
            self.navigationController?.popViewController(animated: true)
            
        })
    }
    
    func caloriesGoalEditedAPI()
    {
        //Request parameters
        let param:Parameters = [AddCaloriesGoalRequestKey.kBurnCalories:self.selectedStepsLbl.text ?? "",
                                AddCaloriesGoalRequestKey.kBurnFreq:self.strActivity ?? "",
                                "id":objCaloriesGoal?.id ?? "",
                                kUserId:AppUserDefaults.getUserID()];
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForAddStepsGoal(url: AddCaloriesGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .put, params: param, complitionHandler: {(Info, error) in
            
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
