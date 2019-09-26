//
//  LoginViewController.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/12/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Alamofire
import Toast
import SVProgressHUD

class LoginViewController: ViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var isFromRegister:Bool?
    let loginManager = LoginManager()
    
    init() {
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    @IBAction func didTapOnBack(_ sender: Any) {
        if isFromRegister! {
            AppDelegate.setInitial()
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func didTapOnForgotPassword(_ sender: Any) {
        let registerVC = ForgotPasswordVC()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @IBAction func didTapOnLogin(_ sender: Any) {
        self.view.endEditing(true)
        
        //Check newtwork connection
        guard NetworkConnectivity.isConnectedToInternet() else{
            AppDelegate.mainWindow().makeToast(kNoInternetConnection)
            return
        }
        
        if self.isValidDataForLogin() {
            self.loginOnServer()
        }
        
    }
    
    @IBAction func didTapOnFacebookLogin(_ sender: Any) {
        
//        //Check newtwork connection
//        guard NetworkConnectivity.isConnectedToInternet() else{
//            AppDelegate.mainWindow().makeToast(kNoInternetConnection)
//            return
//        }
//
//        loginManager.logIn(readPermissions: [ReadPermission.publicProfile], viewController: self) { (loginResult) in
//
//            switch loginResult {
//            case .failed(let error):
//                print(error)
//                AppDelegate.mainWindow().makeToast(error.localizedDescription)
//            case .cancelled:
//                debugPrint("User cancelled login.")
//            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
//                debugPrint("Logged in on FB!", grantedPermissions, declinedPermissions, accessToken)
//
//                //Call Webservice for facebook login
//                self.facebookAuthOnServer()
//            }
//        }
//
    }
    
    // MARK: - Web Service
    private func facebookAuthOnServer() {
        
        //Check newtwork connection
        guard NetworkConnectivity.isConnectedToInternet() else{
            AppDelegate.mainWindow().makeToast(kNoInternetConnection)
            return
        }
        if isLoggedIn() {
            //Request parameters
            let param:Parameters = [:];
            
            //API Call
            SVProgressHUD.show()
            RegisterService.callWSForAuthentication(url: LoginWithFacebbokUrl + "?" + FBLoginRequestKey.kAccessToken + "=" + AccessToken.current!.authenticationToken, httpMethod: .get, params: param, complitionHandler: { (facebookLoginInfo, error) in
                SVProgressHUD.dismiss()
                
                guard error == nil else{
                    AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                    return
                }
                
                guard facebookLoginInfo?.statusCode == StatusCode.kAPILoginSuccess else{
                    AppDelegate.mainWindow().makeToast(facebookLoginInfo?.message)
                    return
                }
                //Set Dashboard
                AppDelegate.mainWindow().makeToast(facebookLoginInfo?.message)
                AppUserDefaults.setUserAuthtoken((facebookLoginInfo?.data?.id)!)
                AppUserDefaults.setUserLoggedIn(true)
                AppDelegate.setDashboard()
            })
        }
    }
    
    private func loginOnServer() {
        
        //Request parameters
        let param:Parameters = [LoginRequestKey.kLoginEmail:txtEmail.text ?? "",
                                LoginRequestKey.kLoginPassword:txtPassword.text ?? ""]
        
        //API Call
        SVProgressHUD.show()
        RegisterService.callWSForAuthentication(url: LoginWithNormalUrl, httpMethod: .post, params: param, complitionHandler: { (loginInfo, error) in
            
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
            AppUserDefaults.setUserAuthtoken((loginInfo?.data?.id)!)
            AppUserDefaults.setUserID((loginInfo?.data?.userid)!)
            AppUserDefaults.setUserLoggedIn(true)
            self.callGetUserApi()
        })
    }
    
    func callGetUserApi()
    {
        SVProgressHUD.show()
        RegisterService.callWSForGetUser(url: CreateUserUrl + "/\(AppUserDefaults.getUserID())" + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .get, complitionHandler: { (loginInfo, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            
            //Set HRA or Dashboard
            if (loginInfo?.hra_ind)! {
                AppUserDefaults.setHRACompleted(true)
                AppDelegate.setDashboard()
            }else{
                AppDelegate.setHRAVC()
            }
        })
    }
    //MARK:- Validation
    private func isValidDataForLogin() -> Bool {
        
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
    
    // MARK: - Facebook Status
    private func isLoggedIn() -> Bool {
        if AccessToken.current != nil {
            return true
        }
        return false
    }
    
    private func logOut() {
        loginManager.logOut()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
