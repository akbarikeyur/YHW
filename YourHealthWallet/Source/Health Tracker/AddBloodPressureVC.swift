//
//  AddBloodPressureVC.swift
//  YourHealthWallet
//
//  Created by Keyur on 27/08/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class AddBloodPressureVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var timeLbl: Label!
    @IBOutlet weak var activityDescTxt: TextField!
    @IBOutlet weak var systolicPickerView: UIPickerView!
    @IBOutlet weak var diastolicPickerView: UIPickerView!
    @IBOutlet weak var pulseRateTxt: TextField!
    @IBOutlet weak var addImageView: UIView!
    @IBOutlet weak var imgBtn: UIButton!
    @IBOutlet weak var noteTxt: TextField!
    @IBOutlet weak var medicationTxt: TextField!
    
    var systolicArr : [String] = [String]()
    var selectedSystolic : Int!
    var diastolicArr : [String] = [String]()
    var selectedDiastolic : Int!

    var selectedDate : Date!
    var selectedTime : Date!

    var selectedImg : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        selectedDate = Date()
        dateLbl.text = "Today"
        selectedTime = Date()
        timeLbl.text = selectedTime!.getDateString(DATE_FORMAT.REMINDER_TIME)
        
        for index in stride(from: 120, to: 40, by: -1) {
            systolicArr.append(String(index))
        }
        selectedSystolic = 10
        systolicPickerView.selectRow(selectedSystolic, inComponent: 0, animated: false)
        systolicPickerView.reloadAllComponents()
        
        diastolicArr = systolicArr
        selectedDiastolic = 40
        diastolicPickerView.selectRow(selectedDiastolic, inComponent: 0, animated: false)
        diastolicPickerView.reloadAllComponents()
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
    
    @IBAction func clickToAddImage(_ sender: UIButton) {
        self.view.endEditing(true)
        uploadImage()
    }
    
    @IBAction func clickToChangeImage(_ sender: Any) {
        self.view.endEditing(true)
        uploadImage()
    }
    
    @IBAction func clickToSave(_ sender: Any) {
        self.view.endEditing(true)
        
        if selectedDate == nil {
            displayToast("Please select date.")
        }
        else if selectedTime == nil {
            displayToast("Please select time.")
        }
        else if pulseRateTxt.text?.trimmed == ""
        {
            displayToast("Please enter pulse rate")
        }
        else if medicationTxt.text?.trimmed == ""
        {
            displayToast("Please enter medication.")
        }
        else if selectedImg == nil
        {
            displayToast("Please add image.")
        }
        else if noteTxt.text?.trimmed == ""
        {
            displayToast("Please enter notes.")
        }
        else
        {
            var param : [String : Any] = [String : Any]()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DATE_FORMAT.REMINDER_SERVER_DATE
            param[AddBloodPressureKey.kBPDate] = dateFormatter.string(from: combineDateWithTime(date: selectedDate, time: selectedTime))
            param[AddBloodPressureKey.kBPSystolic] = selectedSystolic
            param[AddBloodPressureKey.kBPDiastolic] = selectedDiastolic
            param[AddBloodPressureKey.kBPPulserate] = pulseRateTxt.text
            param[AddBloodPressureKey.kBPMedicationname] = medicationTxt.text
            param[AddReminderRequestKey.kUserId] = AppUserDefaults.getUserID()
            
            showProgress()
            BloodPressureService.callWSForAddBloodPressureReading(url: AddBloodPressureReadingUrl, httpMethod: .post, params: param) { (data) in
                hideProgress()
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
        if pickerView == systolicPickerView {
            return systolicArr.count
        }
        else
        {
            return diastolicArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var color: UIColor!
        if pickerView.selectedRow(inComponent: component) == row {
            color = HRBlueColor
        } else {
            color = LightGrayColor
        }
        
        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue) : color, NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont(name: "Roboto-Regular", size: 15.0)!]
        if pickerView == systolicPickerView {
            return NSAttributedString(string: systolicArr[row], attributes: attributes)
        }
        else
        {
            return NSAttributedString(string: diastolicArr[row], attributes: attributes)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
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
        imgBtn.isHidden = false
        selectedImg = selectedImage
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
