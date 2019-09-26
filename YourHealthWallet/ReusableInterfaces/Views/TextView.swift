//
//  TextView.swift
//  
//
//  Created by Shridhar on 5/18/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//@IBDesignable
class TextView: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
       //self.contentInset = UIEdgeInsetsMake(12,12,12,12);
        self.bounces = false
        self.alwaysBounceHorizontal = false
       // self.scrollEnabled = false
        self.textContainer.lineFragmentPadding = 12.0
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable var backGroundColorTypeAdapter : Int32 = 0 {
        didSet {
            self.backgroundColorType = ColorType(rawValue: self.backGroundColorTypeAdapter)
        }
    }
    
    ///text field background color  types
    var backgroundColorType : ColorType? {
        didSet {
            setBackgroundColor(backgroundColorType: backgroundColorType)
        }
    }
    
    /// text field text color  types
    @IBInspectable var textColorTypeAdapter : Int32 = 0 {
        didSet {
            self.textColorType = ColorType(rawValue: self.textColorTypeAdapter)
        }
    }
    
    /// text field text color types
    var textColorType : ColorType? {
        didSet {
            self.textColor = textColorType?.value
        }
        
    }

}
