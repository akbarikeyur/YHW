//
//  MedicationReminderTimesTVC.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/23/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class MedicationReminderTimesTVC: TableViewCell {

    @IBOutlet weak var selectedPeriodLbl: Label!
    
    @IBOutlet weak var firstTimeBtn: Button!
    @IBOutlet weak var secondTimeBtn: Button!
    @IBOutlet weak var thirdTimeBtn: Button!
    
    var strMedicationReminder:String? = "Once a day"

    let _periods:[String] = ["Once a day", "Twice a day", "3 Times a day"]
    var _selectedPeriod:Int!
    
    var _firstTime:Date = Date()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _selectedPeriod = 0
        update()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(){
        selectedPeriodLbl.text = _periods[_selectedPeriod]
    }
    
    //MARK:- Button Tap
    @IBAction func onSelectPeriodBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Period", selected: _periods[_selectedPeriod], strings:_periods) { (value, index, isCancel) in
            if !isCancel {
                self._selectedPeriod = index
                if self._selectedPeriod == 0{
                    self.secondTimeBtn.isHidden = true
                    self.thirdTimeBtn.isHidden = true
                    self.strMedicationReminder = "Once a day"
                }
                if self._selectedPeriod == 1{
                    self.secondTimeBtn.isHidden = false
                    self.thirdTimeBtn.isHidden = true
                    self.strMedicationReminder = "Twice a day"
                }
                if self._selectedPeriod == 2{
                    self.secondTimeBtn.isHidden = false
                    self.thirdTimeBtn.isHidden = false
                    self.strMedicationReminder = "3 Times a day"
                }
                self.update()
            }
        }
    }
    
    @IBAction func onSelectFirstTimeBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Time", selected: _firstTime) { (date, isCancel) in
            if !isCancel && date != nil {
                self.firstTimeBtn.setTitle(date!.getDateString(TIME_FORMAT.DISP_TIME), for: .normal)
            }
        }
    }
    
    @IBAction func onSelectSecondTimeBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Time", selected: _firstTime) { (date, isCancel) in
            if !isCancel && date != nil {
                self.secondTimeBtn.setTitle(date!.getDateString(TIME_FORMAT.DISP_TIME), for: .normal)
            }
        }
    }
    
    @IBAction func onSelectThirdTimeBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Time", selected: _firstTime) { (date, isCancel) in
            if !isCancel && date != nil {
                self.thirdTimeBtn.setTitle(date!.getDateString(TIME_FORMAT.DISP_TIME), for: .normal)
            }
        }
    }
}
