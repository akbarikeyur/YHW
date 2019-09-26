//
//  Label.swift
//  
//
//  Created by Shridhar on 5/18/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit
//import TTTAttributedLabel
//@IBDesignable
class Label: UILabel {
    /// Label text color  types
    @IBInspectable var textColorTypeAdapter : Int32 = 0 {
        didSet {
            self.textColorType = ColorType(rawValue: self.textColorTypeAdapter)
        }
    }
    
    /// Label text color types
    var textColorType : ColorType? {
        didSet {
            self.textColor = textColorType?.value
        }
    }
    
    ///Label background color  types
    @IBInspectable var backgroundColorTypeAdapter : Int32 = 0 {
        didSet {
            self.backgroundColorType = ColorType(rawValue: self.backgroundColorTypeAdapter)
        }
    }
    
    ///Label background color  types
    var backgroundColorType : ColorType? {
        didSet {
            setBackgroundColor(backgroundColorType: backgroundColorType)
        }
    }
}

/*
extension TTTAttributedLabel {
    func boundingRectForCharacterRange(range: NSRange) -> CGRect? {
        
        guard let attributedText = attributedText else { return nil }
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: CGSizeMake(self.bounds.size.width, 200))
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = self.lineBreakMode;
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true
        layoutManager.addTextContainer(textContainer)
        
        var glyphRange = NSRange()
        
        // Convert the range for glyphs.
        layoutManager.characterRangeForGlyphRange(range, actualGlyphRange: &glyphRange)
        
        return layoutManager.boundingRectForGlyphRange(glyphRange, inTextContainer: textContainer)
    }
}
*/
