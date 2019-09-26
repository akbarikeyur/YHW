//
//  MedicationMedicinesTableViewCell.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/22/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class MedicationMedicinesTableViewCell: TableViewCell {

    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var selectedBtn: Button!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
