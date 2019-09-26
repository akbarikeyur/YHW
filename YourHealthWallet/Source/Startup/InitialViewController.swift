//
//  InitialViewController.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/9/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class InitialViewController: ViewController {
    
    init() {
        super.init(nibName: "InitialViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Actions
    @IBAction func didTapOnLogin(_ sender: Any) {
        let loginVC = LoginViewController()
        loginVC.isFromRegister = false
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    @IBAction func didTapOnRegister(_ sender: Any) {
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
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
