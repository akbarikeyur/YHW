//
//  AddDoseSelectMedicationTVC.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/23/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

protocol AddDoseSelectMedicationDelegate {
    func openSelectMedicationPopup()
}
class AddDoseSelectMedicationTVC: TableViewCell {

    var delegate:AddDoseSelectMedicationDelegate?
    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var titleLbl: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK:- Button tap
    @IBAction func onSelectMedicationTap(_ sender: Any) {
        delegate?.openSelectMedicationPopup()
    }
    
}

