//
//  AddHeartRateReadingVC.swift
//  YourHealthWallet
//
//  Created by Keyur on 27/08/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class AddHeartRateReadingVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var timeLbl: Label!
    @IBOutlet weak var heartRateUnitLbl: Label!
    @IBOutlet weak var ratePickerView: UIPickerView!
    @IBOutlet weak var noteTxt: TextField!
    @IBOutlet weak var addImageView: UIView!
    @IBOutlet weak var imgBtn: UIButton!
    
    let rateUnitArr : [String] = ["BPS", "mmHg"]
    var rateArr : [String] = [String]()
    
    var _selectedHeartRate : Int = 0
    var _selectedHeartRateUnit : Int = 0
    var selectedDate : Date!
    var selectedTime : Date!
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ratePickerView.delegate = self
        ratePickerView.dataSource = self
        
        selectedDate = Date()
        dateLbl.text = "Today"
        selectedTime = Date()
        timeLbl.text = selectedTime!.getDateString(DATE_FORMAT.REMINDER_TIME)
        
        for index in stride(from: 120, to: 40, by: -1) {
            rateArr.append(String(index))
        }
        ratePickerView.selectRow(10, inComponent: 0, animated: false)
        ratePickerView.reloadAllComponents()
        _selectedHeartRate = Int(rateArr[10])!
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
    
    @IBAction func clickToSelectHeartRateUnit(_ sender: UIButton) {
        self.view.endEditing(true)
        DPPickerManager.shared.showPicker(title: "Select Unit", selected:rateUnitArr[_selectedHeartRateUnit], strings:rateUnitArr) { (value, index, isCancel) in
            if !isCancel {
                self._selectedHeartRateUnit = index
                self.heartRateUnitLbl.text = self.rateUnitArr[self._selectedHeartRateUnit]
            }
        }
    }
    
    @IBAction func clickToAddImage(_ sender: UIButton) {
        self.view.endEditing(true)
        uploadImage()
    }
    
    @IBAction func clickToChangeImage(_ sender: Any) {
        uploadImage()
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
//        else if selectedImage == nil
//        {
//            displayToast("Please add image.")
//        }
        else
        {
            var param : [String : Any] = [String : Any]()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DATE_FORMAT.REMINDER_SERVER_DATE
            param[AddHeartRateKey.kHRDate] = dateFormatter.string(from: combineDateWithTime(date: selectedDate, time: selectedTime))
            param[AddHeartRateKey.kHRRate] = _selectedHeartRate
            param[AddHeartRateKey.kHRUserId] = AppUserDefaults.getUserID()
//            param[AddHeartRateKey.kHRImage] = ""
            
            HeartRateService.AddHeartRateReading(param, imgArr: [UIImage.init()]) { (result) in
                self.clickCloseToDismiss(self)
            }
            /*
            HeartRateService.AddHeartRateReading(param) { (result) in
                self.navigationController?.popViewController(animated: true)
            }*/
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
        return rateArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var color: UIColor!
        if pickerView.selectedRow(inComponent: component) == row {
            color = HRBlueColor
        } else {
            color = LightGrayColor
        }
        
        let attributes: [NSAttributedStringKey: Any] = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue) : color, NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue) : UIFont(name: "Roboto-Regular", size: 15.0)!]
        return NSAttributedString(string: rateArr[row], attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(rateArr[row])
        _selectedHeartRate = Int(rateArr[row])!
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
        
        selectedImage = (info["UIImagePickerControllerOriginalImage"] as? UIImage)
        if selectedImage == nil {
            return
        }
        addImageView.isHidden = true
        imgBtn.isHidden = false
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
