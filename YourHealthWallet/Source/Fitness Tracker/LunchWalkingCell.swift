//
//  LunchWalkingCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/27/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class LunchWalkingCell: TableViewCell {

    @IBOutlet weak var lblTitle: Label!
    @IBOutlet weak var lblTime: Label!
    @IBOutlet weak var imgList: ImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
