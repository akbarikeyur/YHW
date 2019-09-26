//
//  AddWeightCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/2/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class AddWeightCell: TableViewCell {

    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet var btnWeight: Button!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnWeight.isSelected = false
    }

    @IBAction func didTapOnWeight(_ sender: Any) {
        if btnWeight.isSelected{
            btnWeight.isSelected = false
            txtWeight.placeholder = "0 Kg"
            
        }
        else{
            btnWeight.isSelected = true
            txtWeight.placeholder = "0 lbs"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
