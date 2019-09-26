//
//  StackView.swift
//  YourHealthWallet
//
//  Created by Shridhar on 21/02/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class StackView: UIStackView {
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
