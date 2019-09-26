//
//  RegisterViewController.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/10/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class RegisterViewController: ViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    init() {
        super.init(nibName: "RegisterViewController", bundle: nil)
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
    }
    
    @IBAction func didTapOnRegister(_ sender: UIButton) {
        self.view.endEditing(true)
        
        //Check newtwork connection
        guard NetworkConnectivity.isConnectedToInternet() else{
            AppDelegate.mainWindow().makeToast(kNoInternetConnection)
            return
        }
        
        if self.isValidDataForRegister() {
            self.registerOnServer()
        }
    }
    
    // MARK: - Web Service
    private func registerOnServer() {
        
        //Request parameters
        let param:Parameters = [RegisterRequestKey.kRegisterFirstname:txtFirstName.text ?? "",
                                RegisterRequestKey.kRegisterLastname:txtLastName.text ?? "",
                                RegisterRequestKey.kRegisterEmail:txtEmail.text ?? "",
                                RegisterRequestKey.kRegisterPassword:txtPassword.text ?? ""];
        
        //API Call
        SVProgressHUD.show()
        RegisterService.callWSForAuthentication(url: CreateUserUrl, httpMethod: .post, params: param, complitionHandler: { (registerInfo, error) in
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            
            guard registerInfo?.statusCode == StatusCode.kAPILoginSuccess else{
                AppDelegate.mainWindow().makeToast(registerInfo?.message)
                return
            }
            //Set Dashboard
            AppDelegate.mainWindow().makeToast(registerInfo?.message)
            AppDelegate.setLoginVC()
            
        })
    }
    
    //MARK:- Validation
    private func isValidDataForRegister() -> Bool {
        
        guard isEmptyString(string: txtFirstName?.text) else {
            AppDelegate.mainWindow().makeToast(kFirstNameEmpty)
            return false
        }
        guard isEmptyString(string: txtLastName?.text) else {
            AppDelegate.mainWindow().makeToast(kLastNameEmpty)
            return false
        }
        guard isEmptyString(string: txtEmail?.text) else {
            AppDelegate.mainWindow().makeToast(kEmailEmpty)
            return false
        }
        guard isValidEmailID(checkString: txtEmail?.text) else {
            AppDelegate.mainWindow().makeToast(kEmailValid)
            return false
        }
        guard isEmptyString(string: txtPassword?.text) else {
            AppDelegate.mainWindow().makeToast(kPasswordEmpty)
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
