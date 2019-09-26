//
//  View.swift
//  
//
//  Created by Shridhar on 5/20/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//@IBDesignable
class View: UIView {
    
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
    
    @IBInspectable var circle : Bool = false {
        didSet {
            setCornerRadius(applyCornerRadius: circle, cornerRadius: self.frame.width * 0.5)
        }
    }
    
    ///Border color  types
    @IBInspectable var borderColorTypeAdapter : Int32 = 0 {
        didSet {
            self.borderColorType = ColorType(rawValue: self.borderColorTypeAdapter)
        }
    }
    
    var borderColorType : ColorType? {
        didSet {
            setBorderColor(borderColorType: borderColorType)
        }
    }
    
    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet {
            setBorderWidth(borderWidth: borderWidth)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setGradientBackground(gradientBackgroundType: gradientBackgroundType)
        
        if circle {
            setCornerRadius(applyCornerRadius: circle, cornerRadius: self.frame.width * 0.5)
        } else {
            setCornerRadius(applyCornerRadius: applyCornerRadius, cornerRadius: cornerRadius)
        }
    }
}

extension UIView {
    func setBackgroundColor(backgroundColorType : ColorType?) {
        backgroundColor = backgroundColorType?.value
    }
    
    func setBackgroundColorBar(backgroundColorType : ColorBarType?) {
        backgroundColor = backgroundColorType?.value
    }
    
    func setBorderColor(borderColorType : ColorType?) {
        self.layer.borderColor = borderColorType?.value.cgColor
    }
    
    func setBorderWidth(borderWidth : CGFloat) {
        self.layer.borderWidth = borderWidth
    }
    
    func setCornerRadius(applyCornerRadius : Bool, cornerRadius : CGFloat) {
        if applyCornerRadius {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = false
            self.layer.masksToBounds = false
        } else {
            self.layer.cornerRadius = 0
        }
    }
    
    func setShadow(applyShadow : Bool) {
        if applyShadow {
            self.layer.masksToBounds = false;
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowColor = UIColor(red:0.77, green:0.76, blue:0.76, alpha:0.5).cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowRadius = 12
        } else {
            self.layer.shadowRadius = 0
            self.layer.shadowColor = UIColor.clear.cgColor
        }
    }
    
    func setGradientBackground(gradientBackgroundType : GradientColorType) {
        
        if gradientBackgroundType == .Clear {
            return
        }
        
        if let gradient = self.layer.value(forKeyPath: "GradientLayer") as? GradientLayer {
            gradient.frame = self.bounds
            return
        }
        
        let layer = gradientBackgroundType.layer
        layer.frame = self.bounds
        
        self.layer.insertSublayer(layer, at: 0)
        self.layer.setValue(layer, forKey: "GradientLayer")
    }
    
    
}

