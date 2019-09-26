//
//  MedicationDateCollectionViewCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/23/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class MedicationDateCollectionViewCell: CollectionViewCell {
    
    @IBOutlet var labelDay: Label!
    @IBOutlet weak var labelDayName: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(date: Date) {
        
        let formater = DateFormatter()
        formater.dateFormat = "dd"
        let day = formater.string(from: date)
        labelDay.text = day
        
        formater.dateFormat = "EEEE"
        let dayName = formater.string(from: date)
        labelDayName.text = dayName
    }
}
