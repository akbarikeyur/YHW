//
//  CollectionViewCell.swift
//  YourHealthWallet
//
//  Created by Shridhar on 1/31/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        widthConstraint.constant = UIScreen.main.bounds.width - 20
    }
    
    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if UIApplication.shared.statusBarOrientation == .portrait ||
            UIApplication.shared.statusBarOrientation == .portraitUpsideDown{
            widthConstraint.constant = UIScreen.main.bounds.width - 20
        } else {
            widthConstraint.constant = UIScreen.main.bounds.width * 0.5 - 20
        }
    }
}
