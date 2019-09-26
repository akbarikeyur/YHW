//
//  TableViewCell.swift
//  
//
//  Created by Shaf on 5/24/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

//@IBDesignable
class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initializeTableViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initializeTableViewCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initializeTableViewCell() {
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }

    var parentViewController: UIViewController?
    {
        var parentResponder: UIResponder? = self
        while parentResponder != nil{
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController{
                return parentResponder as! UIViewController!
            }
        }
        return nil
    }
}
