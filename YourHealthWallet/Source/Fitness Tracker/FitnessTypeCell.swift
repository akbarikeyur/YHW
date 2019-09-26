//
//  FitnessTypeCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/20/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class FitnessTypeCell: CollectionViewCell {

    @IBOutlet weak var backContentView: View!
    @IBOutlet weak var goalImageIcon: ImageView!
    @IBOutlet weak var lblFitnessItemName: Label!
    @IBOutlet weak var lblTime: Label!
    @IBOutlet weak var lblDetail: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backContentView.layer.cornerRadius = 5
        self.backContentView.layer.masksToBounds = false
        self.backContentView.clipsToBounds = false
        // Initialization code
    }

}
