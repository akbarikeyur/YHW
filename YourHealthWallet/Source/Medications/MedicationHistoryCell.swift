//
//  MedicationHistoryCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 8/10/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class MedicationHistoryCell: TableViewCell {

    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var timeLbl: Label!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
