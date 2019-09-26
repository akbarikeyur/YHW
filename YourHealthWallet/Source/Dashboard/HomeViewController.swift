//
//  HomeViewController.swift
//  YourHealthWallet
//
//  Created by Shridhar on 2/1/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireJsonToObjects
import HealthKit
import SVProgressHUD

class HomeViewController: ViewController {

    @IBOutlet var dummyNavigationbarTopConstraint: NSLayoutConstraint!
    @IBOutlet var scrollView: ScrollView!
    @IBOutlet var scrollViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var navigationBarHeight: NSLayoutConstraint!
    @IBOutlet var topView: View!
    @IBOutlet var searchTextFiels: TextField!
    
    var weight: Double?
    var bodyHeight: Double?
    var string1:String?
    var string2:String?

    var age: Int?
    var biologicalSex: HKBiologicalSex?
    var bloodType: HKBloodType?

    public init() {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(AppUserDefaults.getUserAuthtoken())
        print(AppUserDefaults.getUserID())
        
        if !AppUserDefaults.isKeyPresentInUserDefaults(key: kIsKg){
            self.callWebServiceForGetHRAData()
        }
        
        initializeHomeViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationBarHeight.constant = navigationController?.navigationBar.frame.height ?? 40
    }
    
    func callWebServiceForGetHRAData() {
        
        SVProgressHUD.show()
        HRAService.callWSForGetHRA(url: GetHRAUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .get) { (hraInfo, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            
            guard let heightType = HKSampleType.quantityType(forIdentifier: .height),
                let weightType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
                    print("Something horrible has happened.")
                    return
            }
            
            HealthManagerKit.Shared.readMostRecentSample(for: heightType) { (sample, error) in
                if let sample = sample {
                    self.bodyHeight = sample.quantity.doubleValue(for: HKUnit.foot())
                    AppUserDefaults.setUserHeight(_height: self.bodyHeight!)
                    AppUserDefaults.setFeetType(true)
                    
                }else{
                    
                    if hraInfo?.newhft != nil {
                        AppUserDefaults.setFeetType(true)
                        
                        if let my1 = hraInfo?.newhft{
                            self.string1 = String(my1)
                        }
                        if let my2 = hraInfo?.newhin{
                            self.string2 = String(my2)
                        }
                        self.bodyHeight = Double(self.string1! + "." + self.string2!)
                        AppUserDefaults.setUserHeight(_height: self.bodyHeight!)
                    }
                    else{
                        AppUserDefaults.setFeetType(false)
                        self.bodyHeight = Double((hraInfo?.newhcm)!)
                        AppUserDefaults.setUserHeight(_height: self.bodyHeight!)
                    }
                }
            }
            
            HealthManagerKit.Shared.readMostRecentSample(for: weightType) { (sample, error) in
                if let sample = sample {
                    self.weight = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                    AppUserDefaults.setKgType(true)
                    AppUserDefaults.setUserWeight(_weight:self.weight!)
                }else{
                    if hraInfo?.newwkg != nil {
                        AppUserDefaults.setKgType(true)
                        self.weight = Double((hraInfo?.newwkg)!)
                        AppUserDefaults.setUserWeight(_weight:self.weight!)
                    }
                    else{
                        AppUserDefaults.setKgType(false)
                        self.weight = Double((hraInfo?.newwlb)!)
                        AppUserDefaults.setUserWeight(_weight:self.weight!)
                    }
                }
            }
            
            //Get AgeSexAndBloodType From HealthKit
            do {
                let userAgeSexAndBloodType = try HealthManagerKit.Shared.getAgeSexAndBloodType()
                self.age = userAgeSexAndBloodType.age
                self.biologicalSex = userAgeSexAndBloodType.biologicalSex
                self.bloodType = userAgeSexAndBloodType.bloodType
                
            } catch let error {
                AppDelegate.mainWindow().makeToast(error.localizedDescription)
            }
            
            //Save Age
            if let ageFromHealthKit = self.age{
                AppUserDefaults.setUserAge(_userAge: ageFromHealthKit)
            }else {
                if let ageFromServer = hraInfo?.age{
                    AppUserDefaults.setUserAge(_userAge: ageFromServer)
                }
            }
            
            //Save Sex
            if let sexFromHealthKit = self.biologicalSex {
                AppUserDefaults.setUserSex(_userAge:sexFromHealthKit.stringRepresentation)
            }else{
                if let sexFromServer = hraInfo?.gender{
                    AppUserDefaults.setUserSex(_userAge: sexFromServer)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

//MARK:- Button Actions
extension HomeViewController {
    
    @IBAction func didTapMenuHamberger(_ sender: UITapGestureRecognizer) {
        self.evo_drawerController?.openDrawerSide(.left, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnYHTTokenViewHolder(_ sender: UITapGestureRecognizer) {
        let yhtTokensVC = YHWTokensViewController()
        self.navigationController?.pushViewController(yhtTokensVC, animated: true)
    }
    
    @IBAction func didTapOnHeartRateViewHolder(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func didTapOnGoalRateViewHolder(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func didTapOnEventsViewHolder(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func didTapOnRemainder(_ sender: UITapGestureRecognizer) {
        let remainderVC = ReminderViewController()
        self.navigationController?.pushViewController(remainderVC, animated: true)
    }
    
    @IBAction func didTapOnDoctorVisits(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func didTapOnFitnessTracker(_ sender: UITapGestureRecognizer) {
        let fitnessTrackerVC = FitnessTrackerTabBarController()
        fitnessTrackerVC.selectedViewControllerIndex = 0
        self.navigationController?.pushViewController(fitnessTrackerVC, animated: true)
        
    }
    
    @IBAction func didTapOnMedication(_ sender: UITapGestureRecognizer) {
        let medicationVC = MedicationsTabBarController()
        self.navigationController?.pushViewController(medicationVC, animated: true)
    }
    
    @IBAction func didTapOnHeartTracker(_ sender: UITapGestureRecognizer) {
        let healthTrackerVC = HealthTrackerViewController()
        self.navigationController?.pushViewController(healthTrackerVC, animated: true)
    }
    
    @IBAction func didTapOnGoals(_ sender: UITapGestureRecognizer) {
        
        let goalTrackerVC = GoalTrackerVC()
        self.navigationController?.pushViewController(goalTrackerVC, animated: true)
    }
}

//MARK:- Private Methods
extension HomeViewController {
    func initializeHomeViewController() {
        //Search
        let leftSearchView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        leftSearchView.image = #imageLiteral(resourceName: "search")
        leftSearchView.contentMode = .center
        searchTextFiels.leftView = leftSearchView
        searchTextFiels.leftViewMode = .always
    }
}
