//
//  HRAAboutVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/4/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit


class HRAAboutVC: ViewController {
    
    @IBOutlet var backView: UIView!
    @IBOutlet var cmsView: UIView!
    
    @IBOutlet var btnHeight: Button!
    @IBOutlet var btnWeight: Button!
    
    @IBOutlet weak var txtHeightInFeet: UITextField!
    @IBOutlet weak var txtHeightInInches: UITextField!
    @IBOutlet weak var txtCms: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    
    @IBOutlet weak var segmentedControlGender: UISegmentedControl!
    
    var pickerView: UIPickerView!
    
    let feetList = Array(1...9)
    let inchList = Array(0...11)
    
    var isFit:Bool?
    var isKg:Bool?
    var weight: Double?
    var bodyHeight: Double?
    
    let numberOfComponents = 4
    
    init() {
        super.init(nibName: "HRAAboutVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isFit = true
        isKg = true
        self.setUpPickerView()
        
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 8
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let title = segmentedControlGender.titleForSegment(at: segmentedControlGender.selectedSegmentIndex)
        AppDelegate.shared().dicHRA.setValue(title, forKey: kHRAGENDER)
        AppDelegate.shared().dicHRA.setValue(txtAge.text, forKey: kHRAAGE)
        
        
        if txtWeight.placeholder == "0 Kg"{
            AppDelegate.shared().dicHRA.setValue(txtWeight.text, forKey: kHRAKG)
        }else{
            AppDelegate.shared().dicHRA.setValue(txtWeight.text, forKey: kHRALB)
        }
        
        if isFit!{
            AppDelegate.shared().dicHRA.setValue(txtHeightInFeet.text, forKey: kHRAFeet)
            AppDelegate.shared().dicHRA.setValue(txtHeightInInches.text, forKey: kHRAInch)
        }
        else{
            AppDelegate.shared().dicHRA.setValue(txtCms.text, forKey: kHRACM)
        }
        
        self.askForHealthKitAccess()
    }
    
    private func askForHealthKitAccess() {
        
        HealthManagerKit.Shared.authorizeHealthKit { (authorized, error) -> Void in
            if !authorized, let error = error {
                self.showAlert(title: "HealthKit Authentication Failed", message: error.localizedDescription)
            }
            else{
                if let textWeight = self.txtWeight.text {
                    self.weight = Double(textWeight)
                }
                
                if self.isFit!{
                    let arrayHeight:[String] = [self.txtHeightInFeet.text!, self.txtHeightInInches.text!]
                    let strHeight = arrayHeight.joined(separator: ".")
                    
                    self.bodyHeight = Double(strHeight)
                }
                else{
                    if let textHeight = self.txtCms.text {
                        self.bodyHeight = Double(textHeight)
                    }
                }
                
                let healthProfileManager = HealthProfileManager()
                healthProfileManager.initWithProfileData(height: self.bodyHeight!, weight:self.weight! , isKilogram: self.isKg!, isFeet: self.isFit!)
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnHeight(_ sender: Any) {
        
        if btnHeight.isSelected{
            txtHeightInFeet.becomeFirstResponder()
            btnHeight.isSelected = false
            cmsView.isHidden = false
            txtHeightInFeet.isHidden = false
            txtCms.isHidden = true
            isFit = true
            AppUserDefaults.setFeetType(isFit!)
        }
        else{
            isFit = false
            AppUserDefaults.setFeetType(isFit!)
            txtCms.becomeFirstResponder()
            btnHeight.isSelected = true
            cmsView.isHidden = true
            txtHeightInFeet.isHidden = true
            txtCms.isHidden = false
        }
    }
    
    
    @IBAction func didTapOnWeight(_ sender: Any) {
        if btnWeight.isSelected{
            btnWeight.isSelected = false
            txtWeight.placeholder = "0 Kg"
            isKg = true
            AppUserDefaults.setFeetType(isKg!)
        }
        else{
            btnWeight.isSelected = true
            txtWeight.placeholder = "0 lbs"
            isKg = false
            AppUserDefaults.setFeetType(isKg!)
        }
    }
    
    
    func setUpPickerView()
    {
        self.pickerView = UIPickerView()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        txtHeightInFeet.inputView = self.pickerView
        txtHeightInInches.inputView = self.pickerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: - UIPickerView Methods
extension HRAAboutVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return feetList.count
        }else if component == 2 {
            return inchList.count
        }else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(feetList[row])"
        }else if component == 1 {
            return "ft"
        }else if component == 2 {
            return "\(inchList[row])"
        }else {
            return "in"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let feetIndex = pickerView.selectedRow(inComponent: 0)
        let inchIndex = pickerView.selectedRow(inComponent: 2)
        self.txtHeightInFeet.text = "\(feetList[feetIndex])"
        self.txtHeightInInches.text = "\(inchList[inchIndex])"
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
