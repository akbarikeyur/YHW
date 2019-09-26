//
//  MedicationListCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/23/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class MedicationListCell: UITableViewCell {

    @IBOutlet var stuffViewHeightConatraint: NSLayoutConstraint!
    @IBOutlet weak var backView: View!

    @IBOutlet weak var imgMedication: ImageView!
    @IBOutlet weak var labelTitle: Label!
    @IBOutlet weak var labelSubTitle: Label!
    @IBOutlet weak var labelTime: Label!
    @IBOutlet weak var btnTick: Button!
    @IBOutlet weak var btnReminder: Button!
    @IBOutlet weak var btnEdit: Button!

    var data : AddMedicationInfo! {
        didSet {
            updateData()
        }
    }
    private func updateData() {
        guard (data != nil) else {
            return
        }
        
        imgMedication.image = #imageLiteral(resourceName: "pill7.png")
        let dateTimeString = Date(fromString: data.medicationstartdate, format: .isoDateTimeMilliSec)?.toString(format: .custom(DATE_FORMAT.MEDICATION_TIME))
        labelTime.text = dateTimeString!
        labelTitle.text = data.medicationname
        labelSubTitle.text = "Take \(data.dosage!)"
        
        if data.selected! {
            stuffViewHeightConatraint.constant = 47
        } else {
            stuffViewHeightConatraint.constant = 0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = false;
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor(red:0.77, green:0.76, blue:0.76, alpha:0.5).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 12
        backView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
