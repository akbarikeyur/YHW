//
//  CollectionView.swift
//  YourHealthWallet
//
//  Created by Shridhar on 2/5/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {
    
    /// background color  types
    @IBInspectable var backgroundColorTypeAdapter : Int32 = 0 {
        didSet {
            self.backgroundColorType = ColorType(rawValue: self.backgroundColorTypeAdapter)
        }
    }
    //    /// background color  types
    var backgroundColorType : ColorType? {
        didSet {
            setBackgroundColor(backgroundColorType: backgroundColorType)
        }
    }
}
