//
//  LeftMenuVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 5/27/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class LeftMenuVC: ViewController {

    public init() {
        super.init(nibName: "LeftMenuVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    // MARK: - Actions
    @IBAction func didTapOnLogOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "YourHealthWallet", message: "Are you sure,you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (alertAction) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (alertAction) in
            
            self.callLogoutApi()
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func didTapOnPrivacyPolicy(_ sender: Any) {

        let webViewController = PrivacyPolicyVC()
        
        // Configure WebViewController
        webViewController.title = "Privacy Policy"
        webViewController.URLToLoad = "https://www.medblocs.io/privacy-policy"
        
        // Customize UI of progressbar
        webViewController.progressTintColor = UIColor.red
        webViewController.trackTintColor = UIColor.brown
        
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func callLogoutApi()
    {
        SVProgressHUD.show()
        
        RegisterService.callWSForLogoutUser(url: LogOutUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .post) { (error) in
        
            SVProgressHUD.dismiss()
            
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()

            AppDelegate.setInitial()
            
        }
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
