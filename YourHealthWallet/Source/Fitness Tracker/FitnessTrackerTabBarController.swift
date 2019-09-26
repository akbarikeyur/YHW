//
//  FitnessTrackerTabBarController.swift
//  YourHealthWallet
//
//  Created by Amisha on 3/9/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//


import Foundation
import HealthKit

import UIKit

class FitnessTrackerTabBarController: TabBarController, UITabBarControllerDelegate {
        
    private var previousSelectedVC : UIViewController?
    var selectedViewControllerIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let vc1 = FitnessTrackerViewController()
        
        let vc2 = FitnessTrackerWalkViewController()
        
        let vc3 = FitnessTrackerRunVC()
        
        let vc4 = FitnessTrackerCycleVC()
        
        let vc5 = FitnessTrackerSleepVC()

        
        vc1.tabBarItem = UITabBarItem(title:nil, image: UIImage.init(named: "dashboard-default"), tag: 0)
        vc2.tabBarItem = UITabBarItem(title:nil, image: UIImage.init(named: "walk-default"), tag: 1)
        vc3.tabBarItem = UITabBarItem(title:nil, image: UIImage.init(named: "run-default"), tag: 2)
        vc4.tabBarItem = UITabBarItem(title:nil, image: UIImage.init(named: "bike-default"), tag: 3)
        vc5.tabBarItem = UITabBarItem(title:nil, image: UIImage.init(named: "sleep-default"), tag: 3)

        let controllers = [vc1, vc2, vc3, vc4, vc5]
        self.viewControllers = controllers
        
        self.delegate = self
        previousSelectedVC = controllers[0]
        self.tabBar.barTintColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(self.triggerAction(_:)), name: NSNotification.Name("NotificationMessageEvent"), object: nil)
        
        
        //set height and weight
        if !AppUserDefaults.isKeyPresentInUserDefaults(key: kIsKg){
            let healthProfileManager = HealthProfileManager()
            healthProfileManager.initWithProfileData(height: AppUserDefaults.getUserHeight(), weight:AppUserDefaults.getUserWeight() , isKilogram: AppUserDefaults.isKgType(), isFeet: AppUserDefaults.isFeetType())
        }
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Default selected
        self.selectedViewController = self.viewControllers?[selectedViewControllerIndex!]
    }
    
    // MARK: - Notification
    @objc func triggerAction(_ notification: Notification?) {
        let dict = notification?.userInfo
        let message = dict?["message"] as? Int
        if message != nil {
            self.selectedViewController = self.viewControllers?[message!]

            // do stuff here with your message data
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController == previousSelectedVC {
            if let navVC = viewController as? UINavigationController {
                navVC.popToRootViewController(animated: true)
            }
        }
        
        previousSelectedVC = viewController
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

