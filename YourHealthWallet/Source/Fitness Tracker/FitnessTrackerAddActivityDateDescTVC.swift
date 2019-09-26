//
//  FitnessTrackerAddActivityDateDescTVC.swift
//  YourHealthWallet
//
//  Created by Amisha on 3/14/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class FitnessTrackerAddActivityDateDescTVC: TableViewCell {

    var _selectedDate:Date = Date()
    
    @IBOutlet weak var dateBtn: Button!
    @IBOutlet weak var descTxtView: PlaceholderTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(){
        dateBtn.setTitle(_selectedDate.getDateString(DATE_FORMAT.DISP_DATE_WITH_FULL_MONTH), for: .normal)
    }
    
    //MARK:- Button Action
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
    
}
