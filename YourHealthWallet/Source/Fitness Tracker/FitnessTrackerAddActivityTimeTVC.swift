//
//  FitnessTrackerAddActivityTimeTVC.swift
//  YourHealthWallet
//
//  Created by PC on 3/14/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class FitnessTrackerAddActivityTimeTVC: TableViewCell {

    @IBOutlet weak var headerLbl: Label!
    @IBOutlet weak var hrText: TextField!
    @IBOutlet weak var minText: TextField!
    @IBOutlet weak var secText: TextField!
    
    let arrHours = Array(0...23)
    let arrMinutes = Array(0...59)
    let arrSeconds = Array(0...59)
    
    let numberOfComponents = 6
    var pickerView: UIPickerView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpPickerView()

    }
    
    func setUpPickerView()
    {
        self.pickerView = UIPickerView()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        hrText.inputView = self.pickerView
        minText.inputView = self.pickerView
        secText.inputView = self.pickerView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - UIPickerView Methods
extension FitnessTrackerAddActivityTimeTVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return arrHours.count
        }else if component == 2 {
            return arrMinutes.count
        }else if component == 4 {
            return arrSeconds.count
        }else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(arrHours[row])"
        }else if component == 1 {
            return "Hrs"
        }else if component == 2 {
            return "\(arrMinutes[row])"
        }else if component == 3 {
            return "Min"
        }else if component == 4 {
            return "\(arrSeconds[row])"
        }else {
            return "Sec"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let hrIndex = pickerView.selectedRow(inComponent: 0)
        let minIndex = pickerView.selectedRow(inComponent: 2)
        let secondIndex = pickerView.selectedRow(inComponent: 4)
        
        self.hrText.text = "\(arrHours[hrIndex])"
        self.minText.text = " \(arrMinutes[minIndex])"
        self.secText.text = " \(arrSeconds[secondIndex])"
    }
}
