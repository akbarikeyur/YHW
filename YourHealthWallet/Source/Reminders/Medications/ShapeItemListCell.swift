//
//  ShapeItemListCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 7/20/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class ShapeItemListCell: TableViewCell {

    @IBOutlet weak var imgBtn: Button!
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var selectedBtn: Button!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
