//
//  HRABaseVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/4/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class HRABaseVC: ViewController{
    
    var pageViewController = HRAPageVC()
    @IBOutlet var contentView: View!
    @IBOutlet var backBtn: Button!
    
    var pageIndex:Int = 0
    
    var zeroVC = HRAAboutVC()
    var firstVC = HRAActivityVC()
    var secondVC = HRAMedicalVC()
    var thirdVC = HRATreatmentVC()
    var fourthVC = HRAMedicinesVC()
    
    
    init() {
        super.init(nibName: "HRABaseVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pageViewController.setViewControllers([zeroVC], direction: .forward, animated: false, completion: nil)
        self.addChildViewController(pageViewController)
        self.contentView.addSubview(pageViewController.view)
        pageViewController.didMove(toParentViewController: self)
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.contentView.frame.size.width, height: self.contentView.frame.size.height))
        
        pageViewController.view.frame = rect
        backBtn.isHidden = true
    }
    
    //MARK: Action
    @IBAction func didTapOnNext(_ sender: Any) {
        
        var viewRight: UIViewController? = nil
        guard pageIndex < 4 else {
            
            //API Call
            SVProgressHUD.show()
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let result = formatter.string(from: currentDate)

            AppDelegate.shared().dicHRA.setValue(result, forKey: "dateadded")
            AppDelegate.shared().dicHRA.setValue(AppUserDefaults.getUserID(), forKey: "userId")
            
            let param:Parameters = AppDelegate.shared().dicHRA as! Parameters
            
            HRAService.callWSForHRA(url: HRAUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .post, params: param, complitionHandler: { (hraInfo, error) in
                
                SVProgressHUD.dismiss()
                
                guard error == nil else{
                    AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                    return
                }
                AppUserDefaults.setHRACompleted(true)
                self.callHRAUpdateForUser()
            })
            return
        }
        backBtn.isHidden = false
        
        //Check validation for HRA's Questions
        switch pageIndex {
        case 0:
            if zeroVC.isFit! {
                guard isEmptyString(string: zeroVC.txtHeightInFeet.text) else {
                    AppDelegate.mainWindow().makeToast(kSelectHeight)
                    return
                }
            }
            else{
                guard isEmptyString(string: zeroVC.txtCms.text) else {
                    AppDelegate.mainWindow().makeToast(kSelectHeight)
                    return
                }
            }
            guard isEmptyString(string: zeroVC.txtWeight.text) else {
                AppDelegate.mainWindow().makeToast(kSelectWeight)
                return
            }
            guard isEmptyString(string: zeroVC.txtAge.text) else {
                AppDelegate.mainWindow().makeToast(kSelectAge)
                return
            }
        case 1:
            guard isEmptyString(string: firstVC.activityLevel) else {
                AppDelegate.mainWindow().makeToast(kSelectAtLeast)
                return
            }
        case 2:
            guard isEmptyString(string: secondVC.medicine) else {
                AppDelegate.mainWindow().makeToast(kSelectAtLeast)
                return
            }
        case 3:
            guard isEmptyString(string: thirdVC.treatment) else {
                AppDelegate.mainWindow().makeToast(kSelectAtLeast)
                return
            }
        case 4:
            guard isEmptyString(string: fourthVC.medicalCon) else {
                AppDelegate.mainWindow().makeToast(kSelectAtLeast)
                return
            }
        default:
            return
        }
        
        pageIndex += 1
        switch pageIndex {
        case 1:
            viewRight = firstVC
        case 2:
            viewRight = secondVC
        case 3:
            viewRight = thirdVC
        case 4:
            viewRight = fourthVC
        default:
            return
        }
        
        pageViewController.setViewControllers([viewRight!], direction: .forward, animated: true, completion: nil)
        
    }
    
    func callHRAUpdateForUser()
    {
        //API Call
        SVProgressHUD.show()
        
        let param:Parameters = ["id":AppUserDefaults.getUserID(),
                                "HRA":true]
        
        HRAService.callWSForUpdateHRA(url: UpdateHRAUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .post, params: param, complitionHandler: { (error) in
            
            SVProgressHUD.dismiss()
            
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            AppDelegate.setDashboard()
        })
    }
    
    @IBAction func didTapOnBack(_ sender: Any) {
        var viewRight: UIViewController? = nil
        
        guard pageIndex > 0 else {
            return
        }
        pageIndex -= 1
        
        
        switch pageIndex {
        case 4:
            viewRight = fourthVC
        case 3:
            viewRight = thirdVC
        case 2:
            viewRight = secondVC
        case 1:
            viewRight = firstVC
        case 0:
            backBtn.isHidden = true
            viewRight = zeroVC
        default:
            //submitData()
            return
        }
        
        pageViewController.setViewControllers([viewRight!], direction: .reverse, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //    func goToRight(viewController:UIViewController) -> UIViewController
    //    {
    //        var nextViewController: UIViewController? = nil
    //
    //        if viewController == zeroVC{
    //            nextViewController = firstVC
    //        }
    //        if viewController == firstVC {
    //            nextViewController = secondVC
    //        }
    //        if viewController == secondVC {
    //            nextViewController = thirdVC
    //        }
    //        if viewController == thirdVC {
    //            nextViewController = fourthVC
    //        }
    //        return nextViewController!
    //    }
    //    func goToLeft(viewController:UIViewController) -> UIViewController
    //    {
    //        var prevViewController: UIViewController? = nil
    //
    //        if viewController == fourthVC{
    //            prevViewController = thirdVC
    //        }
    //        if viewController == thirdVC{
    //            prevViewController = secondVC
    //        }
    //        if viewController == secondVC{
    //            prevViewController = firstVC
    //        }
    //        if viewController == firstVC{
    //            prevViewController = zeroVC
    //        }
    //        return prevViewController!
    //    }
    //    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    //
    //        return goToLeft(viewController: viewController)
    //    }
    //
    //    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    //        return goToRight(viewController: viewController)
    //    }
    //    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    //        guard completed else { return }
    //        pageIndex = pageViewController.viewControllers!.first!.view.tag
    //    }
    
    //    for view: UIView in view.subviews {
    //    if (view is UIScrollView) {
    //    (view as? UIScrollView)?.delegate = self as? UIScrollViewDelegate
    //    break
    //    }
    //    }
    //    // Do any additional setup after loading the view.
}
