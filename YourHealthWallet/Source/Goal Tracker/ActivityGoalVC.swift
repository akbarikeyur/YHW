//
//  ActivityGoalVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/12/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ActivityGoalVC: ViewController {

    @IBOutlet weak var selectedPeriodLbl: Label!
    @IBOutlet weak var txtActiveFor: UITextField!
    var objActivityGoal: AddActivityGoalInfo?

    let _periods:[String] = ["Daily", "Weekly", "Monthly"]
    var _selectedPeriod:Int!
    
    var strActivity:String?
    var strPeriod:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _selectedPeriod = 0;
        
        if AppUserDefaults.isAddedActiveGoal(){
            
            guard objActivityGoal != nil else{
                return
            }
            _selectedPeriod = _periods.index(of: (objActivityGoal?.Activefreq)!)
            txtActiveFor.text = objActivityGoal?.Activefor
            selectedPeriodLbl.text = _periods[_selectedPeriod]
            strPeriod = _periods[_selectedPeriod]
        }
        // Do any additional setup after loading the view.
    }
    func update(){
        selectedPeriodLbl.text = _periods[_selectedPeriod]
    }
    
    //MARK:- Button Tap
    @IBAction func onSelectPeriodBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Period", selected: _periods[_selectedPeriod], strings:_periods) { (value, index, isCancel) in
            if !isCancel {
                self._selectedPeriod = index
                self.strPeriod = value
                self.update()
            }
        }
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveGoalButton(_ sender: Button) {
        if isValidData() {
            if AppUserDefaults.isAddedActiveGoal(){
                self.activityEditGoalAPI()
            }else{
                self.activityGoalAPI()
            }
        }
        
    }
    
    func activityGoalAPI()
    {
        //Request parameters
        let param:Parameters = [AddActivityGoalRequestKey.kActivitfor:txtActiveFor.text ?? "",
                                AddCustomGoalRequestKey.kActivityfreq:self.strPeriod ?? "",
                                kUserId:AppUserDefaults.getUserID()];
        
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForActivityGoal(url: AddActivityGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .post, params: param, complitionHandler: {(Info, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            AppDelegate.mainWindow().makeToast(kSuccessAddGoal)
            AppUserDefaults.setAddedActiveGoal(true)
            self.navigationController?.popViewController(animated: true)
            
        })
    }
    
    func activityEditGoalAPI()
    {
        //Request parameters
        let param:Parameters = [AddActivityGoalRequestKey.kActivitfor:txtActiveFor.text ?? "",
                                AddCustomGoalRequestKey.kActivityfreq:self.strPeriod ?? "",
                                "id":objActivityGoal?.id ?? "",
                                kUserId:AppUserDefaults.getUserID()];
        
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForActivityGoal(url: AddActivityGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .put, params: param, complitionHandler: {(Info, error) in
            
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
        
        guard !(txtActiveFor.text?.isEmpty)! else {
            AppDelegate.mainWindow().makeToast(kEnterActiveTime)
            return false
        }
        
        guard (self.strPeriod != nil) else {
            AppDelegate.mainWindow().makeToast(kSelectActivity)
            return false
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
