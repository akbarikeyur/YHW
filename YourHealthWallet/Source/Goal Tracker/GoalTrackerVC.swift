//
//  GoalTrackerVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/11/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class GoalTrackerVC: ViewController {

    var arrHeaderItem: [Dictionary<String, String>] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnAdd(_ sender: Button) {
        
        self.showPopup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
extension GoalTrackerVC:UIPopoverPresentationControllerDelegate,PopUpHideWithActionDelegate
{
    func showPopup()
    {
        
        arrHeaderItem = [["Title": "Edit Goal", "Icon": "start-activity"],
                             ["Title": "Add Goal", "Icon": "add-activity"],
                             ["Title": "Add Custom Goal", "Icon": "add-activity"]]
        
        let popUpVC = PopOverViewController.init(arrItems: arrHeaderItem)
        popUpVC.delegate = self
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.modalTransitionStyle = .crossDissolve
        popUpVC.preferredContentSize = CGSize.init(width: 200, height: 200)
        let pVC = popUpVC.popoverPresentationController
        pVC?.permittedArrowDirections = .any
        pVC?.delegate = self
        pVC?.sourceView = UIView()
        pVC?.sourceRect = CGRect.init(x: 100, y: 100, width: 1, height: 1)
        pVC?.backgroundColor = UIColor.black
        
        self.navigationController?.present(popUpVC, animated: true, completion: nil)
    }
    
    func isAtLeastOneGoalAdded() -> Bool{
        if AppUserDefaults.isAddedActiveGoal() || AppUserDefaults.isAddedStepsGoal() || AppUserDefaults.isAddedSleepGoal() || AppUserDefaults.isAddedCustomGoal() || AppUserDefaults.isAddedRunGoal() || AppUserDefaults.isAddedCaloriesGoal(){
            return true
        }
        else{
            return false
        }
    }
    
    func isAllGoalsAdded() -> Bool{
        if AppUserDefaults.isAddedActiveGoal() && AppUserDefaults.isAddedStepsGoal() && AppUserDefaults.isAddedSleepGoal() && AppUserDefaults.isAddedCustomGoal() && AppUserDefaults.isAddedRunGoal() && AppUserDefaults.isAddedCaloriesGoal(){
            return true
        }
        else{
            return false
        }
    }
    
    func hideWithIndex(index: NSInteger) {
        switch index {
        case 0:
            if self.isAtLeastOneGoalAdded(){
                let addActivityVC = PickYourGoalVC()
                addActivityVC.isEditGoal = true
                self.navigationController?.pushViewController(addActivityVC, animated: true)
            }
            else{
                AppDelegate.mainWindow().makeToast("Please add at least one goal.")
            }
            break
        case 1:
            if isAllGoalsAdded(){
                AppDelegate.mainWindow().makeToast("You have alraedy added your goals.")
            }else{
                let addActivityVC = PickYourGoalVC()
                self.navigationController?.pushViewController(addActivityVC, animated: true)
            }
            break
        case 2:
            if AppUserDefaults.isAddedCustomGoal(){
                AppDelegate.mainWindow().makeToast("You have alraedy added your custom goal.")
            }else{
                let addActivityVC = CustomGoalVC()
                self.navigationController?.pushViewController(addActivityVC, animated: true)
            }
            break
        default:
            break
        }
        
    }
}
