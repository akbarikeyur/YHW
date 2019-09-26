//
//  backButton.swift
//  
//
//  Created by Shaf on 5/23/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//@IBDesignable
class BackBarButton: BarButtonItem {
    override init() {
        super.init()
    }
    
    
    init(style: UIBarButtonItemStyle, target: AnyObject?, action: Selector) {
        super.init()
        
        var backImage = UIImage(named: "Back Button")
        backImage = backImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.image = backImage
        self.style = style
        self.target = target
        self.action = action
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
