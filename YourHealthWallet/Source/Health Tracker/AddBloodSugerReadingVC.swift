//
//  AddBloodSugerReadingVC.swift
//  YourHealthWallet
//
//  Created by Keyur on 27/08/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class AddBloodSugerReadingVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var timeLbl: Label!
    @IBOutlet weak var activityDescTxt: TextField!
    @IBOutlet weak var statusBtn1: Button!
    @IBOutlet weak var statusBtn2: Button!
    @IBOutlet weak var bloodPickerView: UIPickerView!
    @IBOutlet weak var medicationTxt: TextField!
    @IBOutlet weak var insulinTxt: TextField!
    @IBOutlet weak var addImageView: UIView!
    @IBOutlet weak var imgBtn: UIButton!
    @IBOutlet weak var noteTxt: TextField!
    
    var sugerArr : [String] = [String]()
    var selectedBloodGlucose : Int!

    var selectedDate : Date!
    var selectedTime : Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        selectedDate = Date()
        dateLbl.text = "Today"
        selectedTime = Date()
        timeLbl.text = selectedTime!.getDateString(DATE_FORMAT.REMINDER_TIME)
        
        for index in stride(from: 250, to: 41, by: -1) {
            sugerArr.append(String(index))
        }
        bloodPickerView.selectRow(10, inComponent: 0, animated: false)
        bloodPickerView.reloadAllComponents()
        selectedBloodGlucose = 10
    }

    //MARK: - Button click event
    
    @IBAction func clickCloseToDismiss(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func clickToSelectDate(_ sender: Any) {
        self.view.endEditing(true)
        if selectedDate == nil
        {
            selectedDate = Date()
        }
        let minDate : Date = Date()
        DPPickerManager.shared.showPicker(title: "Select Date", selected: selectedDate, min: minDate, max: nil) { (date, isCancel) in
            if !isCancel && date != nil {
                self.selectedDate = date
                self.dateLbl.text = date!.getDateString(DATE_FORMAT.REMINDER_DATE)
            }
        }
    }
    
    @IBAction func clickToSelectTime(_ sender: Any) {
        self.view.endEditing(true)
        if selectedTime == nil
        {
            selectedTime = Date()
        }
        DPPickerManager.shared.showPicker(title: "Select Time", selected: selectedTime) { (date, isCancel) in
            if !isCancel && date != nil {
                self.selectedTime = date
                self.timeLbl.text = date!.getDateString(DATE_FORMAT.REMINDER_TIME)
            }
        }
    }
    
    @IBAction func clickToSelectStatus(_ sender: UIButton) {
        statusBtn1.isSelected = false
        statusBtn2.isSelected = false
        sender.isSelected = true
    }
    

    @IBAction func clickToAddImage(_ sender: UIButton) {
        self.view.endEditing(true)
        uploadImage()
    }
    
    @IBAction func clickToChangeImage(_ sender: Any) {
        
    }
    
    @IBAction func clickToSave(_ sender: Any) {
        self.view.endEditing(true)
        if selectedDate == nil
        {
            displayToast("Please select date")
        }
        else if selectedTime == nil
        {
            displayToast("Please select time")
        }
        else if medicationTxt.text?.trimmed == ""
        {
            displayToast("Please enter medication.")
        }
        else if insulinTxt.text?.trimmed == ""
        {
            displayToast("Please enter Insulin.")
        }
        else
        {
/*glucose:41
 insulin:50
 userId:5b7bfe1291fb9d0010fc793b
 bsdate:2018-09-01T17:25:53.000+0530
 status:test
 medicationname:Test medication
 bsimages:*/
            
            var param : [String : Any] = [String : Any]()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DATE_FORMAT.REMINDER_SERVER_DATE
            param[AddBloodSugarKey.kBSDate] = dateFormatter.string(from: combineDateWithTime(date: selectedDate, time: selectedTime))
            param[AddBloodSugarKey.kBSGlucose] = selectedBloodGlucose
            param[AddBloodSugarKey.kBSInsulin] = insulinTxt.text
            param[AddHeartRateKey.kHRUserId] = AppUserDefaults.getUserID()
            if statusBtn1.isSelected
            {
                param[AddBloodSugarKey.kBSStatus] = statusBtn1.titleLabel?.text
            }
            else{
                param[AddBloodSugarKey.kBSStatus] = statusBtn2.titleLabel?.text
            }
            param[AddBloodSugarKey.kBSMedication] = medicationTxt.text
            
            BloodSugarService.AddBloodSugarReading(param) { (data) in
                self.clickCloseToDismiss(self)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Pickerview delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sugerArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var color: UIColor!
        if pickerView.selectedRow(inComponent: component) == row {
            color = HRBlueColor
        } else {
            color = LightGrayColor
        }
        
        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue) : color, NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont(name: "Roboto-Regular", size: 15.0)!]
        return NSAttributedString(string: sugerArr[row], attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedBloodGlucose = Int(sugerArr[row])
        pickerView.reloadAllComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    //MARK: - Add Image
    func uploadImage()
    {
        let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelButton = UIAlertAction(title: NSLocalizedString("cancel_picker", comment: ""), style: .cancel) { _ in
        }
        actionSheet.addAction(cancelButton)
        
        let cameraButton = UIAlertAction(title: NSLocalizedString("take_photo", comment: ""), style: .default)
        { _ in
            self.onCaptureImageThroughCamera()
        }
        actionSheet.addAction(cameraButton)
        
        let galleryButton = UIAlertAction(title: NSLocalizedString("existing_photo", comment: ""), style: .default)
        { _ in
            self.onCaptureImageThroughGallery()
        }
        actionSheet.addAction(galleryButton)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc open func onCaptureImageThroughCamera()
    {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            AppDelegate.mainWindow().makeToast(NSLocalizedString("no_camera", comment: ""))
        }
        else {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .camera
            self.present(imgPicker, animated: true, completion: {() -> Void in
            })
        }
    }
    
    @objc open func onCaptureImageThroughGallery()
    {
        self.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .photoLibrary
            self.present(imgPicker, animated: true, completion: {() -> Void in
            })
        }
    }
    
    func imagePickerController(_ imgPicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imgPicker.dismiss(animated: true, completion: {() -> Void in
        })
        
        let selectedImage: UIImage? = (info["UIImagePickerControllerOriginalImage"] as? UIImage)
        if selectedImage == nil {
            return
        }
        addImageView.isHidden = true
        imgBtn.setBackgroundImage(selectedImage, for: .normal)
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
