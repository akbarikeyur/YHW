//
//  CollectionViewCell.swift
//  
//
//  Created by Shridhar on 5/24/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//@IBDesignable
class CollectionViewCell: UICollectionViewCell {
    /// background color  types
    @IBInspectable var backgroundColorTypeAdapter : Int32 = 0 {
        didSet {
            self.backgroundColorType = ColorType(rawValue: self.backgroundColorTypeAdapter)
        }
    }
    
    /// background color  types
    var backgroundColorType : ColorType? {
        didSet {
            self.backgroundColor = backgroundColorType?.value
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 13 {
        didSet {
            setCornerRadius(applyCornerRadius: applyCornerRadius, cornerRadius: cornerRadius)
        }
    }
    @IBInspectable var applyCornerRadius : Bool = false {
        didSet {
            setCornerRadius(applyCornerRadius: applyCornerRadius, cornerRadius: cornerRadius)
        }
    }
    
    @IBInspectable var applyShadow : Bool = false {
        didSet {
            setShadow(applyShadow: applyShadow)
        }
    }
    
    @IBInspectable var gradientBackgroundTypeAdapter : Int32 = 0 {
        didSet {
            gradientBackgroundType = GradientColorType(rawValue: gradientBackgroundTypeAdapter) ?? .Clear
        }
    }
    
    var gradientBackgroundType : GradientColorType = .Clear {
        didSet {
            setGradientBackground(gradientBackgroundType: gradientBackgroundType)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setGradientBackground(gradientBackgroundType: gradientBackgroundType)
    }
}
