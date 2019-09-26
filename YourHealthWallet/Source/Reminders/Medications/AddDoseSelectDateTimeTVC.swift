//
//  AddDoseSelectDateTimeTVC.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/23/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class AddDoseSelectDateTimeTVC: TableViewCell {

    var _selectedDate:Date = Date()
    var _selectedTime:Date = Date()
    @IBOutlet weak var timeBtn: Button!
    @IBOutlet weak var dateBtn: Button!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(){
        dateBtn.setTitle(_selectedDate.getDateString(DATE_FORMAT.DISP_DATE), for: .normal)
        timeBtn.setTitle(_selectedTime.getDateString(TIME_FORMAT.DISP_TIME), for: .normal)
    }
    
    //MARK:- Button Tap
    @IBAction func onDateBtnTap(_ sender: Any) {
        let min = Date()
        let max = min.addingTimeInterval(31536000) // 1 year
        DPPickerManager.shared.showPicker(title: "Select Date", selected: _selectedDate, min: min, max: max) { (date, cancel) in
            if !cancel && date != nil {
                self._selectedDate = date!
                self.update()
            }
        }
    }
    
    @IBAction func onTimeBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select Time", selected:_selectedTime) { (date, isCancel) in
            if !isCancel && date != nil{
                self._selectedTime = date!
                self.update()
            }
        }
    }
    
}
