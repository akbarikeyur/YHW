//
//  ForgotPasswordVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/26/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class ForgotPasswordVC: ViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnBack: Button!
    @IBOutlet weak var btnNext: Button!
    @IBOutlet weak var viewInboxMail: View!
    
    init() {
        super.init(nibName: "ForgotPasswordVC", bundle: nil)
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
    @IBAction func didTapOnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        //self.showView()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        self.view.endEditing(true)
        
        //Check newtwork connection
        guard NetworkConnectivity.isConnectedToInternet() else{
            AppDelegate.mainWindow().makeToast(kNoInternetConnection)
            return
        }
        
        if self.isValidData() {
            self.forwardOnServer()
        }
        
    }
    
    private func forwardOnServer() {
        
        //Request parameters
        let param:Parameters = [LoginRequestKey.kLoginEmail:txtEmail.text ?? ""];
        
        //API Call
        SVProgressHUD.show()
        RegisterService.callWSForAuthentication(url: ForgotPasswordUrl, httpMethod: .post, params: param, complitionHandler: { (loginInfo, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            
            guard loginInfo?.statusCode == StatusCode.kAPILoginSuccess else{
                AppDelegate.mainWindow().makeToast(loginInfo?.message)
                return
            }
            //Set Dashboard
            AppDelegate.mainWindow().makeToast(loginInfo?.message)
            AppUserDefaults.setUserLoggedIn(true)
            AppDelegate.setDashboard()
            
        })
    }
    private func hideView()
    {
        btnNext.isHidden = false
        btnBack.setImage(UIImage.init(named: "back"), for: .normal)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.viewInboxMail.alpha = 0
        }, completion: { _ in
            self.viewInboxMail.isHidden = true
        })
    }
    private func showView()
    {
        btnNext.isHidden = true
        btnBack.setImage(UIImage.init(named: "back"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.viewInboxMail.alpha = 1
        }, completion: { _ in
            self.viewInboxMail.isHidden = false
        })
    }
    //MARK:- Validation
    private func isValidData() -> Bool {
        
        guard isEmptyString(string: txtEmail?.text) else {
            AppDelegate.mainWindow().makeToast(kEmailEmpty)
            return false
        }
        
        guard isValidEmailID(checkString: txtEmail?.text) else {
            AppDelegate.mainWindow().makeToast(kEmailValid)
            return false
        }
        return true
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
