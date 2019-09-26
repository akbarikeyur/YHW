//
//  ViewController.swift
//  
//
//  Created by Shridhar on 5/18/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = .all
        
       // showError()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //firebase recordscreen
        self.recordScreenView()
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title ?? "")" as NSObject,
            AnalyticsParameterItemName: title ?? "" as NSObject,
            AnalyticsParameterContentType: "cont" as NSObject
            ])
    }
    
    func recordScreenView()
    {
        let stringName = self.title
        let screenClass = self.classForCoder.description()
        Analytics.setScreenName(stringName, screenClass: screenClass)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
