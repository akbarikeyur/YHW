//
//  HRAMedicalVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/5/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class HRAMedicalVC: ViewController, HRAChoiceDelegate {

    @IBOutlet weak var hraChoiceView: HRAChoice!
    @IBOutlet var backView: UIView!
    var medicine:String?

    let questionItems = [
        HRAQuestionModel(title: "Anxiety", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Asthma", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Bi-polar Disorder", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Cancer", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "COPD/emphysena", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Coronary Heart Disease", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Dementia", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Depression", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Diabetes", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Hearing problems", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Heart failure", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Hypertension", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Organ trasplant", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Hypertension", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Organ trasplant", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Renal/kidney failure", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Schizophrenia", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Stroke", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "None", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Vision problems", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Other", isSelected: false, isUserSelectEnable: true)
    ]
    
    init() {
        super.init(nibName: "HRAMedicalVC", bundle: nil)
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
        print(AppDelegate.shared().dicHRA)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AppDelegate.shared().dicHRA.setValue(medicine, forKey: kHRAMC)
    }
    
    func setHRAChoice()
    {
        hraChoiceView.isRightToLeft = false
        
        hraChoiceView.delegate = self
        
        hraChoiceView.data = questionItems
        
        hraChoiceView.selectionType = .multiple
        
        hraChoiceView.cellHeight = 60
        
        hraChoiceView.selectedImage = UIImage(named: "check-selected")
        hraChoiceView.unselectedImage = UIImage(named: "check-empty")
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let selectedItemCommaSeparated = hraChoiceView.getSelectedItemsJoined(separator: ",")
        medicine = selectedItemCommaSeparated
    }

}
