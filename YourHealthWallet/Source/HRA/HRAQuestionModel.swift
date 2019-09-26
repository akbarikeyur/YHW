//
//  HRAQuestionModel.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/5/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class HRAQuestionModel: NSObject, Selectable {
    var title: String
    var isSelected: Bool = false
    var isUserSelectEnable: Bool = true
    
    init(title:String,isSelected:Bool,isUserSelectEnable:Bool) {
        self.title = title
        self.isSelected = isSelected
        self.isUserSelectEnable = isUserSelectEnable
    }
}
