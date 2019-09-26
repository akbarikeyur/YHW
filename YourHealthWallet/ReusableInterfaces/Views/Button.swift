//
//  Button.swift
//  
//
//  Created by Shridhar on 5/18/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//@IBDesignable
class Button: UIButton {
    
    /// Button text color  types
    @IBInspectable var textColorTypeAdapter : Int32 = 0 {
        didSet {
            self.textColorType = ColorType(rawValue: self.textColorTypeAdapter)
        }
    }
    
    /// Button text color types
    var textColorType : ColorType? {
        didSet {
            self.setTitleColor(textColorType?.value, for: UIControlState.normal)
        }
    }
    
    ///Button background color  types
    @IBInspectable var backgroundColorTypeAdapter : Int32 = 0 {
        didSet {
            self.backgroundColorType = ColorType(rawValue: self.backgroundColorTypeAdapter)
        }
    }
    
    ///Button background color  types
    var backgroundColorType : ColorType? {
        didSet {
            setBackgroundColor(backgroundColorType: backgroundColorType)
        }
        
    }
    
    ///Button border color  types
    @IBInspectable var borderColorTypeAdapter : Int32 = 0 {
        didSet {
            self.borderColorType = ColorType(rawValue: self.borderColorTypeAdapter)
        }
    }
    
    ///Button border color  types
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
    
    /// Button tint color  types
    @IBInspectable var tintColorTypeAdapter : Int32 = 0 {
        didSet {
            self.tintColorType = ColorType(rawValue: self.tintColorTypeAdapter)
        }
    }
    
    /// Button tint color types
    var tintColorType : ColorType? {
        didSet {
            self.tintColor = tintColorType?.value
        }
    }
    
    ///Button background color  types
    @IBInspectable var backgroundColorBarTypeAdapter : Int32 = 0 {
        didSet {
            self.backgroundColorBarType = ColorBarType(rawValue: self.backgroundColorBarTypeAdapter)
        }
    }
    
    ///Button background color  types
    var backgroundColorBarType : ColorBarType? {
        didSet {
            setBackgroundColorBar(backgroundColorType: backgroundColorBarType)
        }
    }
    
}
