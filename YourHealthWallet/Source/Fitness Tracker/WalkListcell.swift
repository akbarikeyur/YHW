//
//  WalkListcell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/14/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class WalkListcell: TableViewCell {

    @IBOutlet weak var lblDuration: Label!
    @IBOutlet weak var lblTime: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
