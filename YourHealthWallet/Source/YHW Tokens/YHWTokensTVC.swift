//
//  YHWTokensTVC.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/12/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class YHWTokensTVC: TableViewCell {

    @IBOutlet weak var contView: View!
        @IBOutlet weak var yhtLbl: Label!
        @IBOutlet weak var dateTimeLbl: Label!
        @IBOutlet weak var nameLbl: Label!
        @IBOutlet weak var tokenStatusLbl: Label!
        @IBOutlet weak var selectionBtn: Button!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
