//
//  AddDoseDosageTVC.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/23/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class AddDoseDosageTVC: TableViewCell {

    @IBOutlet weak var measureLbl: Label!
    let _measures:[String] = ["mg", "mg1", "mg2"]
    
    var _selectedMeasure:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _selectedMeasure = 0
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(){
        measureLbl.text = _measures[_selectedMeasure]
    }
    
    //MARK:- Button Tap
    @IBAction func onMeasureBtnTap(_ sender: Any) {
        DPPickerManager.shared.showPicker(title: "Select", selected: _measures[_selectedMeasure], strings:_measures) { (value, index, isCancel) in
            if !isCancel {
                self._selectedMeasure = index
                self.update()
            }
        }
    }
}
