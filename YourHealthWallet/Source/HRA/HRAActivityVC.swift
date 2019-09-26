//
//  HRAActivityVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/4/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class HRAActivityVC: ViewController, HRAChoiceDelegate {

    @IBOutlet var backView: UIView!
    var activityLevel:String?
    
    @IBOutlet weak var hraChoiceView: HRAChoice!

    let questionItems = [
        HRAQuestionModel(title: "Once a day", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Once in 2 days", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Once in 2+ days", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Once in a month", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Never", isSelected: false, isUserSelectEnable: true)
        ]
    
    init() {
        super.init(nibName: "HRAActivityVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 8
        self.setHRAChoice()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AppDelegate.shared().dicHRA.setValue(activityLevel, forKey: kHRAEF)
    }
    
    func setHRAChoice()
    {
        hraChoiceView.isRightToLeft = false
        
        hraChoiceView.delegate = self
        
        hraChoiceView.data = questionItems
        
        hraChoiceView.selectionType = .single
        
        hraChoiceView.cellHeight = 60
                
        hraChoiceView.selectedImage = UIImage(named: "check-selected")
        hraChoiceView.unselectedImage = UIImage(named: "check-empty")
    }

    func didSelectRowAt(indexPath: IndexPath) {
        let selectedItemCommaSeparated = hraChoiceView.getSelectedItemsJoined(separator: ",")
        activityLevel = selectedItemCommaSeparated
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
