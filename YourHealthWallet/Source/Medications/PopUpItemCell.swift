//
//  PopUpItemCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/27/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class PopUpItemCell: UITableViewCell {

    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
