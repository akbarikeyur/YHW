//
//  MedicationSelectionTVC.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/23/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

protocol MedicationSelectionDelegate {
    func openSelectionPopup()
}

class MedicationSelectionTVC: TableViewCell {

    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var selectedLbl: Label!
    
    var delegate:MedicationSelectionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Button Tap
    @IBAction func onBtnTap(_ sender: Any) {
        delegate?.openSelectionPopup()
    }
}
