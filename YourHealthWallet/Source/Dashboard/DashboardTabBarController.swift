//
//  DashboardTabBarController.swift
//  YourHealthWallet
//
//  Created by Shridhar on 1/31/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class DashboardTabBarController: TabBarController, UITabBarControllerDelegate {
    
    private var previousSelectedVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let homeDrawerVC = HomeDraverController()
        homeDrawerVC.title = "Favorites"
        
        let downloadsVC = ViewController()
        downloadsVC.title = "Downloads"
        downloadsVC.view.backgroundColor = UIColor.blue
        
        let historyVC = ViewController()
        historyVC.title = "History"
        historyVC.view.backgroundColor = UIColor.cyan
        
        let settings = ViewController()
        settings.title = "Settings"
        settings.view.backgroundColor = UIColor.brown
        
        homeDrawerVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        downloadsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        historyVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        settings.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 3)
        
        let controllers = [homeDrawerVC, downloadsVC, historyVC, settings]
        self.viewControllers = controllers
        
        self.delegate = self
        
        previousSelectedVC = controllers[0]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController == previousSelectedVC {
            if let navVC = viewController as? UINavigationController {
                navVC.popToRootViewController(animated: true)
            } else if let drawer = viewController as? HomeDraverController {
                if drawer.openSide == .left ||
                    drawer.openSide == .right {
                    drawer.closeDrawer(animated: true, completion: nil)
                } else if let navVC = drawer.centerViewController as? UINavigationController {
                    navVC.popToRootViewController(animated: true)
                }
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
