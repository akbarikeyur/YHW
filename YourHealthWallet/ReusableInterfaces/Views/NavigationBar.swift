//
//  NavigationBar.swift
//  
//
//  Created by Shridhar on 5/18/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//@IBDesignable
class NavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeNavigationBar()
    }
    
    func initializeNavigationBar()  {
        self.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.shadowImage = UIImage()
        
        self.isTranslucent = false
    }
    
    var font = UIFont(name: "Avenir-Black", size: 20) {
        didSet {
            //Just to set titleTextAttributes
            textColorTypeAdapter = Int32(textColorTypeAdapter)
        }
    }
    
    
    
    /// Button text color  types
    @IBInspectable var textColorTypeAdapter : Int32 = 0 {
        didSet {
            self.textColorType = ColorType(rawValue: self.textColorTypeAdapter)
        }
    }
    
    /// Button text color types
    var textColorType : ColorType? {
        didSet {
            if textColorType != nil {
                self.titleTextAttributes = [NSAttributedStringKey.foregroundColor : textColorType!.value, NSAttributedStringKey.font: font!]
            }
        }
    }
    
    ///Button background color  types
    @IBInspectable var backgroundColorTypeAdapter : Int32 = 0 {
        didSet {
            self.backgroundColorType = ColorType(rawValue: self.backgroundColorTypeAdapter)
        }
    }
    
    ///Label background color  types
    var backgroundColorType : ColorType? {
        didSet {
            self.barTintColor = backgroundColorType?.value
        }
    }
}
