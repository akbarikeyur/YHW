//
//  HomeDraverController.swift
//  YourHealthWallet
//
//  Created by Shridhar on 1/31/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import DrawerController

class HomeDraverController: DrawerController {

    public init() {
        let left = LeftMenuVC()
        //left.view.backgroundColor = UIColor.purple
        
        let centerVC = HomeViewController()
        let centerNavVC = NavigationController()
        centerNavVC.viewControllers = [centerVC]
        super.init(centerViewController: centerVC, leftDrawerViewController: left, rightDrawerViewController: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.openDrawerGestureModeMask = .all
        self.closeDrawerGestureModeMask = .all
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
