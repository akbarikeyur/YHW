//
//  HTBodyWeightCell.swift
//  YourHealthWallet
//
//  Created by Shridhar on 23/02/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class HTBodyWeightCell: CollectionViewCell {

    @IBOutlet weak var labelBig: Label!
    @IBOutlet weak var labelSmall: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let textContent = "75kg"
        let textString = NSMutableAttributedString(string: textContent, attributes: [
            NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 14)!
            ])
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.92
        textString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range: textRange)
        labelSmall.attributedText = textString
    }
}
