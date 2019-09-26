//
//  DayHeaderCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/23/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class DayHeaderCell: UITableViewCell {

    @IBOutlet  var imgHeader: ImageView!
    @IBOutlet  var labelTitle: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
