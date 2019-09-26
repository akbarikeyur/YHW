//
//  NavigationController.swift
//
//
//  Created by Shridhar on 5/23/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    init () {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = .all
        
        // Do any additional setup after loading the view.
        
        //Gradient Navigation bar
        /*
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.statusBarFrame.width, height: UIApplication.shared.statusBarFrame.height + self.navigationController!.navigationBar.frame.height)
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [UIColor(red:0.08, green:0.53, blue:0.8, alpha:1).cgColor,
                           UIColor(red:0.17, green:0.2, blue:0.7, alpha:1).cgColor]
        self.view.layer.addSublayer(gradient)
        self.view.backgroundColor = UIColor.clear
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
