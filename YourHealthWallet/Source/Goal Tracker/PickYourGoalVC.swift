//
//  PickyYourGoalVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/13/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

let ITEM_SPACING = 10
let kHorizontalInsets = 15
let kVerticalInsets = 10
let ITEMS_PER_ROW = 2


class PickYourGoalVC:ViewController {
    
    @IBOutlet weak var collView: CollectionView!
    @IBOutlet weak var btnTitle: Button!
    @IBOutlet weak var btnSaveGoal: Button!
    var arrHeaderItem: [[String:Any]] = []
    var isEditGoal: Bool? = false
    
    var objActivityGoal: AddActivityGoalInfo?
    var objSleepGoal: AddSleepGoalInfo?
    var objStepsGoal: AddStepsGoalInfo?
    var objCustomGoal: AddCustomGoalInfo?
    var objRunGoal: AddRunGoalInfo?
    var objCaloriesGoal: AddCaloriesGoalInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        arrHeaderItem = [["Icon": "PFIttness_Tracker Icon",
                          "goalValue": "30 Mins",
                          "goalType": "Activity"],
                         
                         ["Icon": "",
                          "goalValue": "10000",
                          "goalType": "Steps"],
                         
                         ["Icon": "",
                          "goalValue": "07 Hrs",
                          "goalType": "Sleep"],
                         
                         ["Icon": "",
                          "goalValue": "01 Mile",
                          "goalType": "Running"],
                         
                         ["Icon": "",
                          "goalValue": "4000",
                          "goalType": "Calories"],
                            ]
        
        collView.register(UINib(nibName: String(describing:PickGoalListCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:PickGoalListCell.self))
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isEditGoal! {
            
            self.btnTitle.setTitle("Edit Your Goal", for: .normal)
            self.btnSaveGoal.setTitle("EDIT YOUR CUSTOM GOAL", for: .normal)
            AppUserDefaults.isAddedActiveGoal() ? self.getActivityGoal() : nil
            AppUserDefaults.isAddedStepsGoal() ? self.getStepsGoal() : nil
            AppUserDefaults.isAddedSleepGoal() ? self.getSleepGoal() : nil
            AppUserDefaults.isAddedCustomGoal() ? self.getCustomGoal() : nil
            AppUserDefaults.isAddedRunGoal() ? self.getRunGoal() : nil
            AppUserDefaults.isAddedCaloriesGoal() ? self.getCaloriesGoal() : nil
        }
        else
        {
            self.btnTitle.setTitle("Pick Your Goal", for: .normal)
            self.btnSaveGoal.setTitle("ADD YOUR CUSTOM GOAL", for: .normal)
            
        }
    }
    
    func reloadActiveGoalItem(objInfo:AddActivityGoalInfo?){
        
        self.arrHeaderItem[0] = ["Icon": "PFIttness_Tracker Icon",
                                 "goalValue": objInfo?.Activefor ?? "",
                                 "goalType": "Activity"]
        self.collView.reloadData()
    }
    
    func reloadStepsGoalItem(objInfo:AddStepsGoalInfo?){
        let wordToRemove = " Steps"
        if let range = objInfo?.Willwalk.range(of: wordToRemove) {
            objInfo?.Willwalk.removeSubrange(range)
        }
        self.arrHeaderItem[1] = ["Icon": "",
                                 "goalValue": objInfo?.Willwalk ?? "",
                                 "goalType": "Steps"]
        self.collView.reloadData()
    }
    
    func reloadSleepGoalItem(objInfo:AddSleepGoalInfo?){
        self.arrHeaderItem[2] = ["Icon": "",
                                 "goalValue": objInfo?.Willsleep ?? "",
                                 "goalType": "Sleep"]
        self.collView.reloadData()
    }
    
    func reloadRunGoalItem(objInfo:AddRunGoalInfo?){
        self.arrHeaderItem[3] = ["Icon": "",
                                 "goalValue": objInfo?.runfor ?? "",
                                 "goalType": "Running"]
        self.collView.reloadData()
    }
    
    func reloadCaloriesGoalItem(objInfo:AddCaloriesGoalInfo?){
        let wordToRemove = " Calories"
        if let range = objInfo?.burncalories.range(of: wordToRemove) {
            objInfo?.burncalories.removeSubrange(range)
        }
        self.arrHeaderItem[4] = ["Icon": "",
                                 "goalValue": objInfo?.burncalories ?? "",
                                 "goalType": "Calories"]
        self.collView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapCustomGoalButton(_ sender: Button) {
        if isEditGoal!{
            if AppUserDefaults.isAddedCustomGoal(){
                let addActivityVC = CustomGoalVC()
                addActivityVC.objCustomGoal = self.objCustomGoal
                self.navigationController?.pushViewController(addActivityVC, animated: true)
            }else{
                AppDelegate.mainWindow().makeToast("Please first add your custom goal.")
            }
        }else{
            if AppUserDefaults.isAddedCustomGoal(){
                AppDelegate.mainWindow().makeToast("You have already added custom goal.")
            }else{
                let addActivityVC = CustomGoalVC()
                self.navigationController?.pushViewController(addActivityVC, animated: true)
            }
        }
    }
    
    func getActivityGoal()
    {
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForActivityGetGoal(url: GetActivityGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .get, complitionHandler: {(objInfo, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            self.objActivityGoal = objInfo
            self.reloadActiveGoalItem(objInfo: objInfo)
        })
    }
    
    func getSleepGoal()
    {
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForSleepGetGoal(url: GetSleepGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .get, complitionHandler: {(objInfo, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            self.objSleepGoal = objInfo
            self.reloadSleepGoalItem(objInfo: objInfo)
        })
    }
    
    func getStepsGoal()
    {
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForStepsGetGoal(url: GetStepsGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .get, complitionHandler: {(objInfo, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            self.objStepsGoal = objInfo
            self.reloadStepsGoalItem(objInfo: objInfo)

        })
    }
    
    func getRunGoal()
    {
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForRunGetGoal(url: GetRunGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .get, complitionHandler: {(objInfo, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            self.objRunGoal = objInfo
            self.reloadRunGoalItem(objInfo: objInfo)
        })
    }
    
    func getCaloriesGoal()
    {
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForCaloriesGetGoal(url: GetCaloriesGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .get, complitionHandler: {(objInfo, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            self.objCaloriesGoal = objInfo
            self.reloadCaloriesGoalItem(objInfo: objInfo)
        })
    }

    func getCustomGoal()
    {
        //API Call
        SVProgressHUD.show()
        GoalTrackerService.callWSForCustomGetGoal(url: GetCustomGoalUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .get, complitionHandler: {(objInfo, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            self.objCustomGoal = objInfo
            
        })
    }
}

extension PickYourGoalVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:PickGoalListCell.self), for: indexPath) as! PickGoalListCell
        
        
        switch indexPath.item {
        case 0:
            cell.backContentView.gradientBackgroundType = GradientColorType.MedicationsPurpule
            break
        case 1:
            cell.backContentView.gradientBackgroundType = GradientColorType.HealthTrackerOrange
            break
        case 2:
            cell.backContentView.gradientBackgroundType = GradientColorType.FitnessTrackerSleepColor
            break
        case 3:
            cell.backContentView.gradientBackgroundType = GradientColorType.FitnessTrackerRunPink
            break
        case 4:
            cell.backContentView.gradientBackgroundType = GradientColorType.FitnessTrackerSleepColor
            break
        default:
            print("")
        }
        cell.goalImageIcon.image = UIImage.init(named: arrHeaderItem[indexPath.item]["Icon"] as! String)
        cell.goalPeriod.text = arrHeaderItem[indexPath.item]["goalValue"] as? String
        cell.goalItems.text = arrHeaderItem[indexPath.item]["goalType"] as? String
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(CGFloat(kVerticalInsets), CGFloat(kHorizontalInsets), CGFloat(kVerticalInsets), CGFloat(kHorizontalInsets))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemWidth:CGFloat = 0
        var itemHeight:CGFloat = 0
        itemWidth = (collectionView.bounds.size.width - (1 + CGFloat(ITEMS_PER_ROW)) * CGFloat(kHorizontalInsets)) / CGFloat(ITEMS_PER_ROW)
        itemHeight = itemWidth * 0.8
        
        return CGSize(width: CGFloat(itemWidth), height: CGFloat(itemHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(kVerticalInsets)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(kHorizontalInsets)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isEditGoal!{
            switch indexPath.item {
            case 0:
                if AppUserDefaults.isAddedActiveGoal(){
                    let addActivityVC = ActivityGoalVC()
                    addActivityVC.objActivityGoal = self.objActivityGoal
                    self.navigationController?.pushViewController(addActivityVC, animated: true)
                }else{
                    AppDelegate.mainWindow().makeToast("Please first add your active goal.")
                }
            case 1:
                if AppUserDefaults.isAddedStepsGoal(){
                    let addActivityVC = StepsGoalVC()
                    addActivityVC.objStepsGoal = self.objStepsGoal
                    self.navigationController?.pushViewController(addActivityVC, animated: true)
                }else{
                    
                    AppDelegate.mainWindow().makeToast("Please first add your steps goal.")
                }
            case 2:
                if AppUserDefaults.isAddedSleepGoal(){
                    let addActivityVC = SleepGoalVC()
                    addActivityVC.objSleepGoal = self.objSleepGoal
                    self.navigationController?.pushViewController(addActivityVC, animated: true)
                }else{
                    AppDelegate.mainWindow().makeToast("Please first add your sleep goal.")
                }
            case 3:
                if AppUserDefaults.isAddedRunGoal(){
                    let runGoalVC = RunGoalVC()
                    runGoalVC.objRunGoal = self.objRunGoal
                    self.navigationController?.pushViewController(runGoalVC, animated: true)
                }else{
                    AppDelegate.mainWindow().makeToast("Please first add your run goal.")
                }
            case 4:
                if AppUserDefaults.isAddedCaloriesGoal(){
                    let runGoalVC = CaloriesGoalVC()
                    runGoalVC.objCaloriesGoal = self.objCaloriesGoal
                    self.navigationController?.pushViewController(runGoalVC, animated: true)
                }else{
                    AppDelegate.mainWindow().makeToast("Please first add your calories goal.")
                }
            default:
                print("")
            }
            
        }else{
            switch indexPath.item {
            case 0:
                if AppUserDefaults.isAddedActiveGoal(){
                    AppDelegate.mainWindow().makeToast("You have already added active goal.")
                }else{
                    let addActivityVC = ActivityGoalVC()
                    self.navigationController?.pushViewController(addActivityVC, animated: true)
                }
            case 1:
                if AppUserDefaults.isAddedStepsGoal(){
                    AppDelegate.mainWindow().makeToast("You have already added step goal.")
                }else{
                    let addActivityVC = StepsGoalVC()
                    self.navigationController?.pushViewController(addActivityVC, animated: true)
                }
            case 2:
                if AppUserDefaults.isAddedSleepGoal(){
                    AppDelegate.mainWindow().makeToast("You have already added sleep goal.")
                }else{
                    let addActivityVC = SleepGoalVC()
                    self.navigationController?.pushViewController(addActivityVC, animated: true)
                }
            case 3:
                if AppUserDefaults.isAddedRunGoal(){
                    AppDelegate.mainWindow().makeToast("You have already added run goal.")
                }else{
                    let addActivityVC = RunGoalVC()
                    self.navigationController?.pushViewController(addActivityVC, animated: true)
                }
            case 4:
                if AppUserDefaults.isAddedCaloriesGoal(){
                    AppDelegate.mainWindow().makeToast("You have already added calories.")
                }else{
                    let addActivityVC = CaloriesGoalVC()
                    self.navigationController?.pushViewController(addActivityVC, animated: true)
                }
            default:
                print("")
            }
        }
    }
}
