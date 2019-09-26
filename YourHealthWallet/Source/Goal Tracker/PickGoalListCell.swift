//
//  PickGoalListCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/13/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class PickGoalListCell: CollectionViewCell {

    @IBOutlet weak var backContentView: View!
    @IBOutlet weak var goalImageIcon: ImageView!
    @IBOutlet weak var goalPeriod: Label!
    @IBOutlet weak var goalItems: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backContentView.layer.cornerRadius = 5
        self.backContentView.layer.masksToBounds = true
        // Initialization code
    }

}
