//
//  SegmentedControl.swift
//  
//
//  Created by Shridhar on 6/3/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

class SegmentedControl: UISegmentedControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func initializeSegmentedControl() {
//        self.tintColor = DarkGrayBGColor
//        
//        let normalFont = UIFont(name: "Avenir-Regular", size: 13.0)
//        let selectedFont = UIFont(name: "Avenir-Medium", size: 13.0)
//        let normalAttr = [NSAttributedStringKey.font : normalFont!, NSAttributedStringKey.foregroundColor : ButtonBackgroundColor] as [NSAttributedStringKey : Any]
//        let selectedAttr = [NSAttributedStringKey.font : selectedFont!, NSAttributedStringKey.foregroundColor : PureWhiteColor] as [NSAttributedStringKey : Any]
//        
//        
//        self.setTitleTextAttributes(normalAttr, for: UIControlState.normal)
//        self.setTitleTextAttributes(selectedAttr, for: UIControlState.selected)
//        self.tintColor = DarkGrayBGColor
    }
}
