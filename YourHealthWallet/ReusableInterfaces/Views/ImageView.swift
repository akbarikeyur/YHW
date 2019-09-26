//
//  ImageView.swift
//  
//
//  Created by Shridhar on 5/18/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//@IBDesignable
class ImageView: UIImageView {
    
    var isDownloadingImage = false
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialzeImageView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialzeImageView()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        initialzeImageView()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        
        initialzeImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initialzeImageView() {
//        kf_showIndicatorWhenLoading = true
    }

    func downloadImage(from url : String?, placeHolderImageName : String?) {
//        isDownloadingImage = true
//
//        let placeHolder = placeHolderImageName != nil ? UIImage(named: placeHolderImageName!) : nil
//
//        if isEmptyString(string: url) == false {
//            self.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: placeHolder, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
//                self.isDownloadingImage = false
//                if image == nil {
//                    self.image = placeHolder
//                }
//            })
//        } else {
//            isDownloadingImage = false
//            self.image = placeHolder
//        }
    }
}
