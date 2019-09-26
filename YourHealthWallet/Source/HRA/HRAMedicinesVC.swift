//
//  HRAMedicinesVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/6/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class HRAMedicinesVC: ViewController,HRAChoiceDelegate {

    @IBOutlet weak var hraChoiceView: HRAChoice!
    @IBOutlet var backView: UIView!
    var medicalCon:String?

    let questionItems = [
        HRAQuestionModel(title: "0", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "1-3", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "4-5", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "6-7", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "8+", isSelected: false, isUserSelectEnable: true),
    ]
    
    init() {
        super.init(nibName: "HRAMedicinesVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 8
        self.setHRAChoice()
        AppDelegate.shared().dicHRA.setValue(medicalCon, forKey: kHRAMD)
        // Do any additional setup after loading the view.
    }
    
    func setHRAChoice()
    {
        hraChoiceView.isRightToLeft = false
        
        hraChoiceView.delegate = self
        
        hraChoiceView.data = questionItems
        
        hraChoiceView.selectionType = .single
        
        hraChoiceView.cellHeight = 60
        
        hraChoiceView.selectedImage = UIImage(named: "radio-on")
        hraChoiceView.unselectedImage = UIImage(named: "radio-off")
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let selectedItemCommaSeparated = hraChoiceView.getSelectedItemsJoined(separator: ",")
        AppDelegate.shared().dicHRA.setValue(selectedItemCommaSeparated, forKey: kHRAMD)
    }

}
