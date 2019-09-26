//
//  MedicationReportTableViewCell.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/22/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class MedicationReportTableViewCell: TableViewCell {

    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var descLbl: Label!
    @IBOutlet weak var warningbtn: Button!
    @IBOutlet weak var timeLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
