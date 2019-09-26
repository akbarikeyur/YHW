//
//  TextField.swift
//  
//
//  Created by Shridhar on 5/18/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//@IBDesignable
class TextField: UITextField {
    
    var actualFontColor : UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.width))
        self.leftViewMode = UITextFieldViewMode.always
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        self.rightViewMode = UITextFieldViewMode.always
    }

    ///text field background color  types
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
    
       /**
     *  Error Handling
     */
    func showerrorMessages(status : Bool, message: String?) {
        
        if status == false {
            self.text = message
            if actualFontColor != nil {
                self.textColor = actualFontColor
            }
        }
        else{
            self.text = message
            actualFontColor = self.textColor
            self.textColor = ColorType.Red.value
        }
    }
}
