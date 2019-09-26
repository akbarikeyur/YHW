//
//  MedicationsTabBarController.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/21/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import Foundation

import UIKit

class MedicationsTabBarController: TabBarController, UITabBarControllerDelegate {
    
    private var previousSelectedVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let medicationDayVC = MedicationsDaywiseViewController()
        medicationDayVC.title = "Medications"
        
        let medicationAllVC = MedicationMedicinesViewController()
        medicationAllVC.title = "Medications"
        
        let medicationReportsVC = MedicationHistoryVC()
        medicationReportsVC.title = "Medication History"
        
        medicationDayVC.tabBarItem = UITabBarItem(title:nil, image: UIImage.init(named: "Dashboard-Selected"), tag: 0)
        medicationAllVC.tabBarItem = UITabBarItem(title:nil, image: UIImage.init(named: "medicines-default"), tag: 1)
        medicationReportsVC.tabBarItem = UITabBarItem(title:nil, image: UIImage.init(named: "reports-default"), tag: 2)
        
        let controllers = [medicationDayVC, medicationAllVC,medicationReportsVC]
        self.viewControllers = controllers
        
        self.delegate = self
        
        previousSelectedVC = controllers[0]
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
