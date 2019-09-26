//
//  RemindersCollectionViewCell.swift
//  YourHealthWallet
//
//  Created by Shridhar on 2/6/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class RemindersCollectionViewCell: CollectionViewCell {

    @IBOutlet var cellWidthConatraint: NSLayoutConstraint!

    @IBOutlet weak var leftView: View!
    @IBOutlet weak var imageView: ImageView!
    @IBOutlet weak var labelTime: Label!
    @IBOutlet weak var labelTitle: Label!
    
    var data : AddReminderInfo! {
        didSet {
            updateData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configureLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureLayout()
    }
    
    private func configureLayout() {
        if UIApplication.shared.statusBarOrientation == .portrait ||
            UIApplication.shared.statusBarOrientation == .portraitUpsideDown {
            cellWidthConatraint.constant = UIScreen.main.bounds.width - 40
        } else {
            cellWidthConatraint.constant = UIScreen.main.bounds.width - 60
        }
    }
    
    private func updateData() {
        guard (data != nil) else {
            return
        }
        
        if let dict : [String : Any] = dictReminder[data.remindertype]
        {
            leftView.backgroundColor = dict["color"] as? UIColor ?? .red
            imageView.image = UIImage.init(named: dict["icon"] as! String)
        }
        else
        {
            leftView.backgroundColorType = .Purpule
            imageView.image = #imageLiteral(resourceName: "YHT.png")
        }
        labelTitle.text = data.remindertype
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DATE_FORMAT.REMINDER_SERVER_DATE
        let reminderDate : Date = dateFormatter.date(from: data.reminderstartdate)!
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DATE_FORMAT.REMINDER_TIME
        labelTime.text = dateFormatter.string(from: reminderDate)
        
    }
}
