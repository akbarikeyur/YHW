//
//  RemindersDateCollectionViewCell.swift
//  YourHealthWallet
//
//  Created by Shridhar on 2/5/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class RemindersDateCollectionViewCell: CollectionViewCell {
    
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
