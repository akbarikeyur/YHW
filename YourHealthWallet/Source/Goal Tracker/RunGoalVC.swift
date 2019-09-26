//
//  RunGoalVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 8/4/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class RunGoalVC:ViewController {
    
    @IBOutlet weak var selectedPeriodLbl: Label!
    @IBOutlet weak var selectedStepsLbl: Label!
    var objRunGoal: AddRunGoalInfo?
    
    let _periods:[String] = ["Daily", "Weekly", "Monthly"]
    let _steps:[String] = ["01","02","03","04","05","06","07","08","09","10"]
    
    var _selectedPeriod:Int!
    var _selectedSteps:Int!
    
    var strActivity:String?
    var stepCount:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _selectedPeriod = 0
        _selectedSteps = 0
        
        if AppUserDefaults.isAddedRunGoal(){
            
            guard objRunGoal != nil else{
                return
            }
            _selectedPeriod = _periods.index(of: (objRunGoal?.runfreq)!)
            if let range = objRunGoal?.runfor.range(of: " Mile") {
                objRunGoal?.runfor.removeSubrange(range)
            }
            _selectedSteps = _steps.index(of: (objRunGoal?.runfor)!)
            strActivity = objRunGoal?.runfreq
            stepCount = objRunGoal?.runfor
            selectedPeriodLbl.text = objRunGoal?.runfreq
            selectedStepsLbl.text = objRunGoal?.runfor
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
        DPPickerManager.shared.showPicker(title: "Select Mile", selected: _steps[_selectedSteps], strings:_steps) { (value, index, isCancel) in
            if !isCancel {
                self._selectedSteps = index
                self.stepCount = value
                self.selectedStepsLbl.text = self._steps[self._selectedSteps] + " Mile"
                
            }
        }
    }
    
    @IBAction func saveGoalButton(_ sender: Button) {
        if isValidData() {
            if AppUserDefaults.isAddedRunGoal(){
                self.runGoalEditedAPI()
            }else{
                self.runGoalAPI()
            }
        }
    }
    
    func runGoalAPI()
    {
        //Request parameters
        let param:Parameters = [AddRunGoalRequestKey.kRunFor:self.selectedStepsLbl.text ?? "",
                                AddRunGoalRequestKey.kRunfreq:self.strActivity ?? "",
                                kUserId:AppUserDefaults.getUserID()];
        
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForAddRunGoal(url: AddRunGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .post, params: param, complitionHandler: {(Info, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            AppDelegate.mainWindow().makeToast(kSuccessAddGoal)
            AppUserDefaults.setAddedRunGoal(true)
            self.navigationController?.popViewController(animated: true)
            
        })
    }
    
    func runGoalEditedAPI()
    {
        //Request parameters
        let param:Parameters = [AddRunGoalRequestKey.kRunFor:self.selectedStepsLbl.text ?? "",
                                AddRunGoalRequestKey.kRunfreq:self.strActivity ?? "",
                                "id":objRunGoal?.id ?? "",
                                kUserId:AppUserDefaults.getUserID()];
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForAddStepsGoal(url: AddRunGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .put, params: param, complitionHandler: {(Info, error) in
            
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
            AppDelegate.mainWindow().makeToast(kSelectMile)
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
