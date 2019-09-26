//
//  MedicationAddEditVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 8/20/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class MedicationAddEditVC: ViewController,HRAChoiceDelegate,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var txtMedicationName: UITextField!
    @IBOutlet var titleButton: UIButton?

    @IBOutlet weak var prescribedBtn: Button!
    @IBOutlet weak var counterBtn: Button!
    var strMeicationCategory:String? = "Prescribed"
    
    @IBOutlet weak var selectedMedicationTypeLbl: Label!
    
    @IBOutlet weak var selectedMedicationReminderLbl: Label!
    @IBOutlet weak var firstTimeBtn: Button!
    @IBOutlet weak var secondTimeBtn: Button!
    @IBOutlet weak var thirdTimeBtn: Button!
    let _reminderTimePeriods:[String] = ["Once a day", "Twice a day", "3 Times a day"]
    var _selectedMedicationReminderPeriod:Int!
    var _reminderFirstTime:Date = Date()
    
    @IBOutlet weak var dosageTxt: TextField!
    @IBOutlet weak var txtUnit: TextField!
    let _measures:[String] = ["0.5", "1", "1.5","2","5","10"]
    let _units:[String] = ["ml","mg","mcg","gr"]
    let _doasage:[String] = ["0.25", "0.50", "0.75","1","2","3","4","5","6","7","8","9","10"]
    let numberOfComponents = 2
    var pickerView: UIPickerView!
    var _selectedMeasure:Int!
    var _selectedDosage:Int!
    
    var _selectedScheduleDate:Date = Date()
    @IBOutlet weak var dateBtn: Button!
    @IBOutlet weak var continuousBtn: Button!
    @IBOutlet weak var noOfDaysBtn: Button!
    @IBOutlet weak var lblNumberOfDays: Label!
    @IBOutlet weak var everyDayBtn: Button!
    @IBOutlet weak var specificDayBtn: Button!
    @IBOutlet weak var lblSpecificDays: Label!
    @IBOutlet weak var intervalDayBtn: Button!
    @IBOutlet weak var lblDaysIntercal: Label!
    var lblDuration: String? = "Continuous"
    var lblDays: String? = "Everyday"
    let numDays : [String] = ["1 Days", "2 Days", "3 Days", "4 Days","5 Days"]
    let arrdaysInterval:[String] = ["Every 2 days", "Every 3 days", "Every 4 days", "Every 5 days"]
    
    @IBOutlet weak var selectedMediumLbl: Label!
    
    @IBOutlet weak var selectedShapeLbl: Label!
    @IBOutlet weak var imgBtnShape: Button!
    
    @IBOutlet weak var selectedColorLbl: Label!
    @IBOutlet weak var imgBtnColor: Button!
    
    @IBOutlet weak var beforeFoodBtn: Button!
    @IBOutlet weak var withFoodBtn: Button!
    @IBOutlet weak var afterFoodBtn: Button!
    @IBOutlet weak var noFoodInstructionBtn: Button!
    var selectedInstuction: String? = "Before Food"
    
    @IBOutlet weak var txtNote:PlaceholderTextView!
    
    var _selectedMedium:Int!
    var _selectedShape:Int!
    var _selectedColor:Int!
    var _selectedMedication:Int!
    
    //Content View
    @IBOutlet var selectShapeMedicationContView: View!
    @IBOutlet var selectColorMedicationContView: View!
    @IBOutlet var selectSpecificDaysContView: View!
    
    //Tableview
    @IBOutlet weak var selectShapeMedicationItemTblView: TableView!
    @IBOutlet weak var selectColorMedicationItemTblView: TableView!
    @IBOutlet weak var selectSpecificDaysTblview: HRAChoice!
    
    var isEditMedicine: Bool? = false
    var arrShapeItem: [Dictionary<String, String>] = []
    
    var arrColorItem:[String] = ["Black", "Blue", "Brown","Gray","Green","Orange","Purple","Red","White","Yellow"]
    
    var arrColors:[UIColor] = [UIColor.black,UIColor.blue,UIColor.brown,UIColor.gray,UIColor.green,UIColor.orange,UIColor.purple,UIColor.red,UIColor.white,UIColor.yellow]
    
    let _medium:[String] = ["Water", "Milk", "Without Both"]
    
    let _arrMedicationType:[String] = ["Capsule", "Powder", "Drops","Syrup","Injection", "Lotion", "Mouthwash","Ointment","Cream","Others"]
    
    let identifierShapeItem:String = "ShapeItemListCell"
    let identifierColorItem:String = "ColorItemCell"
    
    let questionItems = [
        HRAQuestionModel(title: "Sunday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Monday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Tuesday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Wednesday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Thursday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Friday", isSelected: false, isUserSelectEnable: true),
        HRAQuestionModel(title: "Saturday", isSelected: false, isUserSelectEnable: true),
        ]
    
    var editMedicationObj:AddMedicationInfo?
    
    
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _selectedShape = 0
        _selectedColor = 1
        _selectedMedication = 0
        _selectedMedicationReminderPeriod = 0
        selectedMedicationTypeLbl.text = _arrMedicationType[_selectedMedication]
        selectedMedicationReminderLbl.text = _reminderTimePeriods[_selectedMedicationReminderPeriod]
        _selectedMeasure = 0
        _selectedDosage = 0
        dosageTxt.text = _doasage[_selectedDosage]
        
        self.dateBtn.setTitle(_selectedScheduleDate.getDateString(DATE_FORMAT.DISP_DATE_WITH_DAY), for: .normal)
        _selectedMedium = 0
        selectedMediumLbl.text = _medium[_selectedMedium]
        
        arrShapeItem = [["Title": "Capsule", "Icon": "shape1"],
                        ["Title": "Diamond", "Icon": "shape1"],
                        ["Title": "Clover", "Icon": "shape1"],
                        ["Title": "Heptagon", "Icon": "shape1"],
                        ["Title": "Hexagon", "Icon": "shape1"],
                        ["Title": "Octagon", "Icon": "shape1"],
                        ["Title": "Pentagon", "Icon": "shape1"],
                        ["Title": "Oval", "Icon": "shape1"],
                        ["Title": "Round", "Icon": "shape1"]]
        
        selectShapeMedicationItemTblView.register(UINib(nibName: identifierShapeItem, bundle: nil), forCellReuseIdentifier: identifierShapeItem)
        
        selectColorMedicationItemTblView.register(UINib(nibName: identifierColorItem, bundle: nil), forCellReuseIdentifier: identifierColorItem)
        
        //Check is Edit Or Not
        self.isEditMedication()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Button Action
    @IBAction func didTapOnCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOTCSelection(_ sender: Any) {
        let senderBtn = sender as? UIButton
        var index: Int = 2001
        while (self.view.viewWithTag(index) != nil) {
            let button = self.view.viewWithTag(index) as? UIButton
            if senderBtn?.isEqual(button) ?? false {
                button?.isSelected = true
                if index == 2001{
                    self.strMeicationCategory = "Prescribed"
                }else{
                    self.strMeicationCategory = "Over the counter"
                }
            }
            else {
                button?.isSelected = false
            }
            index += 1
        }
    }
    
    @IBAction func onBtnTap(_ sender: Any) {
        
        DPPickerManager.shared.showPicker(title: "Select Medication Type", selected:_arrMedicationType[_selectedMedication], strings:_arrMedicationType) { (value, index, isCancel) in
            if !isCancel {
                self._selectedMedication = index
                self.selectedMedicationTypeLbl.text = self._arrMedicationType[self._selectedMedication]
            }
        }
    }
    
    @IBAction func onSelectPeriodBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Period", selected: _reminderTimePeriods[_selectedMedicationReminderPeriod], strings:_reminderTimePeriods) { (value, index, isCancel) in
            if !isCancel {
                self._selectedMedicationReminderPeriod = index
                if self._selectedMedicationReminderPeriod == 0{
                    self.secondTimeBtn.isHidden = true
                    self.thirdTimeBtn.isHidden = true
                    self.selectedMedicationReminderLbl.text = "Once a day"
                }
                if self._selectedMedicationReminderPeriod == 1{
                    self.secondTimeBtn.isHidden = false
                    self.thirdTimeBtn.isHidden = true
                    self.selectedMedicationReminderLbl.text = "Twice a day"
                }
                if self._selectedMedicationReminderPeriod == 2{
                    self.secondTimeBtn.isHidden = false
                    self.thirdTimeBtn.isHidden = false
                    self.selectedMedicationReminderLbl.text = "3 Times a day"
                }
            }
        }
    }
    
    @IBAction func onSelectFirstTimeBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Time", selected: _reminderFirstTime) { (date, isCancel) in
            if !isCancel && date != nil {
                self.firstTimeBtn.setTitle(date!.getDateString(TIME_FORMAT.DISP_TIME), for: .normal)
            }
        }
    }
    
    @IBAction func onSelectSecondTimeBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Time", selected: _reminderFirstTime) { (date, isCancel) in
            if !isCancel && date != nil {
                self.secondTimeBtn.setTitle(date!.getDateString(TIME_FORMAT.DISP_TIME), for: .normal)
            }
        }
    }
    
    @IBAction func onSelectThirdTimeBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Time", selected: _reminderFirstTime) { (date, isCancel) in
            if !isCancel && date != nil {
                self.thirdTimeBtn.setTitle(date!.getDateString(TIME_FORMAT.DISP_TIME), for: .normal)
            }
        }
    }
    
    func setUpPickerView()
    {
        self.pickerView = UIPickerView()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        txtUnit.inputView = self.pickerView
    }
    
    //MARK:- Button Tap
    @IBAction func onMeasureBtnTap(_ sender: Any) {
        self.setUpPickerView()
        txtUnit.becomeFirstResponder()
    }
    
    @IBAction func onDosageBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select", selected: _doasage[_selectedDosage], strings:_doasage) { (value, index, isCancel) in
            if !isCancel {
                self._selectedDosage = index
                self.dosageTxt.text = self._doasage[self._selectedDosage]
            }
        }
    }
    
    @IBAction func onDateBtnTap(_ sender: Any) {
        let min = Date()
        let max = min.addingTimeInterval(31536000) // 1 year
        DPPickerManager.shared.showPicker(title: "Select Date", selected: _selectedScheduleDate, min: min, max: max) { (date, cancel) in
            if !cancel && date != nil {
                self._selectedScheduleDate = date!
                self.dateBtn.setTitle(self._selectedScheduleDate.getDateString(DATE_FORMAT.DISP_DATE_WITH_DAY), for: .normal)
            }
        }
    }
    
    @IBAction func btnDurationSelection(_ sender: Any) {
        let senderBtn = sender as? UIButton
        var index: Int = 211
        while (self.view.viewWithTag(index) != nil) {
            let button = self.view.viewWithTag(index) as? UIButton
            if senderBtn?.isEqual(button) ?? false {
                button?.isSelected = true
                if(index == 212){
                    lblNumberOfDays.isHidden = false
                    
                    DPPickerManager.shared.showPicker(title: "Set Number Of Days", selected:self.numDays[0], strings:self.numDays) { (value, index, isCancel) in
                        if !isCancel {
                            self.lblNumberOfDays.text = self.numDays[index]
                            self.lblDuration = self.numDays[index]
                        }
                    }
                }else{
                    lblNumberOfDays.isHidden = true
                    self.lblDuration = "Continuous"
                }
            }
            else {
                button?.isSelected = false
            }
            index += 1
        }
    }
    
    @IBAction func btnDaysSelection(_ sender: Any) {
        let senderBtn = sender as? UIButton
        var index: Int = 311
        while (self.view.viewWithTag(index) != nil) {
            let button = self.view.viewWithTag(index) as? UIButton
            if senderBtn?.isEqual(button) ?? false {
                button?.isSelected = true
                if(index == 312){
                    lblSpecificDays.isHidden = false
                    self.openChoiceofDays()
                }else{
                    lblSpecificDays.isHidden = true
                }
                if(index == 313){
                    lblDaysIntercal.isHidden = false
                    
                    DPPickerManager.shared.showPicker(title: "Set Day Interval", selected:self.arrdaysInterval[0], strings:self.arrdaysInterval) { (value, index, isCancel) in
                        if !isCancel {
                            self.lblDaysIntercal.text = self.arrdaysInterval[index]
                            self.lblDays = self.arrdaysInterval[index]
                        }
                    }
                }else{
                    lblDaysIntercal.isHidden = true
                }
                
            }
            else {
                button?.isSelected = false
            }
            index += 1
        }
    }
    
    func openChoiceofDays() {
        setHRAChoice()
        DPPickerManager.shared.showPicker(title: "Select specific days", view: selectSpecificDaysContView) { (isCancel) in
        }
    }
    
    //Selected specific days
    func setHRAChoice()
    {
        selectSpecificDaysTblview.isRightToLeft = false
        
        selectSpecificDaysTblview.delegate = self
        
        selectSpecificDaysTblview.data = questionItems
        
        selectSpecificDaysTblview.selectionType = .multiple
        selectSpecificDaysTblview.cellHeight = 60
        
        selectSpecificDaysTblview.selectedImage = UIImage(named: "check-selected")
        selectSpecificDaysTblview.unselectedImage = UIImage(named: "check-empty")
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        let selectedItemCommaSeparated = selectSpecificDaysTblview.getSelectedItemsJoined(separator: ",")
        
        self.lblSpecificDays.text = selectedItemCommaSeparated
        self.lblDays = self.lblSpecificDays.text
    }
    
    //MARK:- Button Tap
    @IBAction func onMediumBtnTap(_ sender: Any) {
        
        DPPickerManager.shared.showPicker(title: "Select Medium", selected:_medium[_selectedMedium], strings:_medium) { (value, index, isCancel) in
            if !isCancel {
                self._selectedMedium = index
                self.selectedMediumLbl.text = self._medium[self._selectedMedium]
            }
        }
    }
    
    @IBAction func onBtnShapeTap(_ sender: Any) {
        
        self.selectShapeMedicationItemTblView.reloadData()
        DPPickerManager.shared.showPicker(title: "Select Shape", view: selectShapeMedicationContView) { (isCancel) in
        }
    }
    @IBAction func onBtnColorTap(_ sender: Any) {
        
        self.selectColorMedicationItemTblView.reloadData()
        DPPickerManager.shared.showPicker(title: "Select Color", view: selectColorMedicationContView) { (isCancel) in
        }
    }
    
    @IBAction func onInstructionTap(_ sender: Any) {
        let senderBtn = sender as? UIButton
        var index: Int = 611
        while (self.view.viewWithTag(index) != nil) {
            let button = self.view.viewWithTag(index) as? UIButton
            if senderBtn?.isEqual(button) ?? false {
                button?.isSelected = true
                self.selectedInstuction = senderBtn?.titleLabel?.text
            }
            else {
                button?.isSelected = false
            }
            index += 1
        }
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == selectShapeMedicationItemTblView){
            return arrShapeItem.count
        }
        else{
            return arrColorItem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == selectShapeMedicationItemTblView){
            let cell :ShapeItemListCell = tableView.dequeueReusableCell(withIdentifier: identifierShapeItem) as! ShapeItemListCell
            cell.imgBtn.setImage(UIImage(named: arrShapeItem[indexPath.row]["Icon"]!), for: .normal)
            cell.titleLbl.text = arrShapeItem[indexPath.row]["Title"]!
            if(_selectedShape == indexPath.row){
                cell.selectedBtn.isHidden = false
            }
            else{
                cell.selectedBtn.isHidden = true
            }
            return cell
        }
            
        else{
            
            let cell :ColorItemCell = tableView.dequeueReusableCell(withIdentifier: identifierColorItem) as! ColorItemCell
            
            cell.imgBtn.backgroundColor = arrColors[indexPath.row]
            cell.titleLbl.text = arrColorItem[indexPath.row]
            if(_selectedColor == indexPath.row){
                cell.selectedBtn.isHidden = false
            }
            else{
                cell.selectedBtn.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView == selectShapeMedicationItemTblView){
            let selectedCell:ShapeItemListCell  = tableView.cellForRow(at: indexPath) as! ShapeItemListCell
            selectedCell.selectedBtn.isHidden = false
            
            self.imgBtnShape.setImage(selectedCell.imgBtn.image(for: .normal), for: .normal)
            self.selectedShapeLbl.text = selectedCell.titleLbl.text
            _selectedShape =  indexPath.row
            DPPickerManager.shared.pickerClose(self)
        }
        else if(tableView == selectColorMedicationItemTblView){
            let selectedCell:ColorItemCell  = tableView.cellForRow(at: indexPath) as! ColorItemCell
            selectedCell.selectedBtn.isHidden = false
            
            self.imgBtnColor.backgroundColor = arrColors[indexPath.row]
            self.selectedColorLbl.text = arrColorItem[indexPath.row]
            
            _selectedColor =  indexPath.row
            DPPickerManager.shared.pickerClose(self)
        }
    }
    
    
    private func isValidData() -> Bool {
        
        if(txtMedicationName.text == ""){
            AppDelegate.mainWindow().makeToast(kEnterMedicationName)
            return false
        }
        if(self.txtUnit.text == "Select Unit"){
            AppDelegate.mainWindow().makeToast(kEnterMedUnit)
            return false
        }
        if(self.txtNote.text?.isEmpty)!{
            AppDelegate.mainWindow().makeToast(kEnterMedNote)
            return false
        }
        
        return true
    }
    
    //MARK:- Button Tap
    @IBAction func onSaveMedicationBtnTap(_ sender: Any) {
        if isValidData(){
            print(self.txtMedicationName.text!,self.strMeicationCategory!,self.selectedMedicationTypeLbl.text!,self.selectedMedicationReminderLbl.text!,self.dosageTxt.text!.floatValue,self.txtUnit.text!,self._selectedScheduleDate.toString(format: .isoDateTimeSec, timeZone: .utc, locale: .current),self.lblDuration!,self.lblDays!,self.selectedMediumLbl.text!,self.selectedShapeLbl.text!,self.selectedColorLbl.text!,self.selectedInstuction!,self.txtNote.text!)
            
            //Request parameters
            var param:Parameters = [AddMedicationRequestKey.kMedicationName:self.txtMedicationName.text!,
                                    AddMedicationRequestKey.kMedicationstartdate:self._selectedScheduleDate.toString(format: .isoDateTimeSec, timeZone: .utc, locale: .current),
                                    AddMedicationRequestKey.kMedicationcategory:self.strMeicationCategory!,
                                    AddMedicationRequestKey.kMedicationtype:self.selectedMedicationTypeLbl.text!,
                                    AddMedicationRequestKey.kRemindertimes:self.selectedMedicationReminderLbl.text!,
                                    AddMedicationRequestKey.kDosage:self.dosageTxt.text!.floatValue,
                                    AddMedicationRequestKey.kDosageunit:self.txtUnit.text!,
                                    AddMedicationRequestKey.kDuration:self.lblDuration!,
                                    AddMedicationRequestKey.kDaysfrequency:self.lblDays!,
                                    AddMedicationRequestKey.kMedium:self.selectedMediumLbl.text!,
                                    AddMedicationRequestKey.kShape:self.selectedShapeLbl.text!,
                                    AddMedicationRequestKey.kColor:self.selectedColorLbl.text!,
                                    AddMedicationRequestKey.kInstructions:self.selectedInstuction!,
                                    AddMedicationRequestKey.kMedicationnotes:self.txtNote.text!,
                                    kUserId:AppUserDefaults.getUserID()];
            
            if isEditMedicine!{
                param["id"] = self.editMedicationObj?.id
                print(param)
                //API Call
                SVProgressHUD.show()
                MedicationsService.callWSForAddMedication(url: AdduserMedicinesUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .put, params: param, complitionHandler: {(Info, error) in
                    
                    SVProgressHUD.dismiss()
                    guard error == nil else{
                        AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                        return
                    }
                    AppDelegate.mainWindow().makeToast(kSuccessMedicationEdited)
                    self.dismiss(animated: true, completion: nil)
                    
                })
            }
            else
            {
                //API Call
                SVProgressHUD.show()
                MedicationsService.callWSForAddMedication(url: AdduserMedicinesUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .post, params: param, complitionHandler: {(Info, error) in
                    
                    SVProgressHUD.dismiss()
                    guard error == nil else{
                        AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                        return
                    }
                    AppDelegate.mainWindow().makeToast(kSuccessMedicationAdded)
                    self.dismiss(animated: true, completion: nil)
                    
                })
            }
            
        }
    }
    
    
    func isEditMedication(){
        
        if isEditMedicine!{
            self.titleButton?.setTitle("  Edit Medicine", for: .normal)
            self.txtMedicationName.text = self.editMedicationObj?.medicationname
            self.strMeicationCategory = self.editMedicationObj?.medicationcategory
            if self.strMeicationCategory == "Prescribed"{
                self.prescribedBtn.isSelected = true
                self.counterBtn.isSelected = false
            }
            else{
                self.prescribedBtn.isSelected = false
                self.counterBtn.isSelected = true
            }
            self.selectedMedicationTypeLbl.text = self.editMedicationObj?.medicationtype
            self.selectedMedicationReminderLbl.text = self.editMedicationObj?.remindertimes
            self.dosageTxt.text = self.editMedicationObj?.dosage.description
            self.txtUnit.text = self.editMedicationObj?.dosageunit
            self._selectedScheduleDate = Date(fromString: (self.editMedicationObj?.medicationstartdate)!, format: .isoDateTimeMilliSec)!
            self.dateBtn.setTitle(_selectedScheduleDate.getDateString(DATE_FORMAT.DISP_DATE_WITH_DAY), for: .normal)
            self.lblDuration = self.editMedicationObj?.duration
            if self.lblDuration == "Continuous"{
                self.lblNumberOfDays.isHidden = true
                self.continuousBtn.isSelected = true
                self.noOfDaysBtn.isSelected = false
            }
            else{
                self.noOfDaysBtn.isSelected = true
                self.continuousBtn.isSelected = false
                self.lblNumberOfDays.isHidden = false
                self.lblNumberOfDays.text = self.lblDuration
            }
            
            self.lblDays = self.editMedicationObj?.daysfrequency
            
            if self.lblDays == "Everyday"{
                self.lblSpecificDays.isHidden = true
                self.lblDaysIntercal.isHidden = true
                self.everyDayBtn.isSelected = true
                self.specificDayBtn.isSelected = false
                self.intervalDayBtn.isSelected = false
            }
            else if (self.lblDays?.contains("Every"))!
            {
                self.lblSpecificDays.isHidden = true
                self.lblDaysIntercal.isHidden = false
                self.everyDayBtn.isSelected = false
                self.specificDayBtn.isSelected = false
                self.intervalDayBtn.isSelected = true
                self.lblDaysIntercal.text = self.lblDays
            }
            else{
                self.lblSpecificDays.isHidden = false
                self.lblDaysIntercal.isHidden = true
                self.everyDayBtn.isSelected = false
                self.specificDayBtn.isSelected = true
                self.intervalDayBtn.isSelected = false
                self.lblSpecificDays.text = self.lblDays
            }
            
            self.selectedMediumLbl.text = self.editMedicationObj?.medium
            self.selectedShapeLbl.text = self.editMedicationObj?.shape
            self.selectedColorLbl.text = self.editMedicationObj?.color
            self.selectedInstuction = self.editMedicationObj?.instructions
            if self.selectedInstuction == "Before Food"{
                self.beforeFoodBtn.isSelected = true
                self.withFoodBtn.isSelected = false
                self.afterFoodBtn.isSelected = false
                self.noFoodInstructionBtn.isSelected = false
            }
            else if self.selectedInstuction == "With Food"{
                self.beforeFoodBtn.isSelected = false
                self.withFoodBtn.isSelected = true
                self.afterFoodBtn.isSelected = false
                self.noFoodInstructionBtn.isSelected = false
            }
            else if self.selectedInstuction == "After Food"{
                self.beforeFoodBtn.isSelected = false
                self.withFoodBtn.isSelected = false
                self.afterFoodBtn.isSelected = true
                self.noFoodInstructionBtn.isSelected = false
            }
            else if self.selectedInstuction == "No Food Instructions"{
                self.beforeFoodBtn.isSelected = false
                self.withFoodBtn.isSelected = false
                self.afterFoodBtn.isSelected = false
                self.noFoodInstructionBtn.isSelected = true
            }
            
            self.txtNote.text = self.editMedicationObj?.medicationnotes
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UIPickerView Methods
extension MedicationAddEditVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return _measures.count
        }else{
            return _units.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(_measures[row])"
        }else{
            return "\(_units[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let measure = pickerView.selectedRow(inComponent: 0)
        let unit = pickerView.selectedRow(inComponent: 1)
        self.txtUnit.text = "\(_measures[measure])"+" "+"\(_units[unit])"
    }
}
