//
//  SleepGoalVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/13/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class SleepGoalVC: ViewController {
    
    @IBOutlet weak var selectedPeriodLbl: Label!
    @IBOutlet weak var txtSleepTime: UITextField!
    var objSleepGoal: AddSleepGoalInfo?
    
    let _periods:[String] = ["Daily", "Weekly", "Monthly"]
    var _selectedPeriod:Int!
    
    var strActivity:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _selectedPeriod = 0
        
        if AppUserDefaults.isAddedSleepGoal(){
            
            guard objSleepGoal != nil else{
                return
            }
            
            _selectedPeriod = _periods.index(of: (objSleepGoal?.sleepfreq)!)
            txtSleepTime.text = objSleepGoal?.Willsleep
            selectedPeriodLbl.text = _periods[_selectedPeriod]
            strActivity = _periods[_selectedPeriod]
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
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveGoalButton(_ sender: Button) {
        if isValidData() {
            
            if AppUserDefaults.isAddedSleepGoal(){
                self.sleepGoalEditAPI()
            }else{
                self.sleepGoalAPI()
            }
        }
        
    }
    
    func sleepGoalAPI()
    {
        //Request parameters
        let param:Parameters = [AddSleepGoalRequestKey.kWillSleep:txtSleepTime.text ?? "",
                                AddSleepGoalRequestKey.kSleepfreq:self.strActivity ?? "",
                                kUserId:AppUserDefaults.getUserID()];
        
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForAddSleepGoal(url: AddSleepGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .post, params: param, complitionHandler: {(Info, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            AppDelegate.mainWindow().makeToast(kSuccessAddGoal)
            AppUserDefaults.setAddedSleepGoal(true)
            self.navigationController?.popViewController(animated: true)
            
            
        })
    }
    
    func sleepGoalEditAPI()
    {
        //Request parameters
        let param:Parameters = [AddSleepGoalRequestKey.kWillSleep:txtSleepTime.text ?? "",
                                AddSleepGoalRequestKey.kSleepfreq:self.strActivity ?? "",
                                "id":objSleepGoal?.id ?? "",
                                kUserId:AppUserDefaults.getUserID()];
        
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForAddSleepGoal(url: AddSleepGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .put, params: param, complitionHandler: {(Info, error) in
            
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
        
        guard !(txtSleepTime.text?.isEmpty)! else {
            AppDelegate.mainWindow().makeToast(kEnterSleepTime)
            return false
        }
        
        guard (self.strActivity != nil) else {
            AppDelegate.mainWindow().makeToast(kSelectActivity)
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
