//
//  WeightImageListCell.swift
//  ImageAddRemoveDemo
//
//  Created by Mac-Vishal on 04/06/18.
//  Copyright © 2018 Mac-Vishal. All rights reserved.
//

import UIKit

class WeightImageListCell: UICollectionViewCell {

    @IBOutlet weak var imgItem : UIImageView!
    var indexPath:IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configureCellWithImage(imageSting:String, withIndexPath:IndexPath)
    {
        self.imgItem.image =  UIImage.init(imageLiteralResourceName: imageSting)
        indexPath = withIndexPath
    }
    
}
