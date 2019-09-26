//
//  GradientLayer.swift
//  YourHealthWallet
//
//  Created by Shridhar on 2/1/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class GradientLayer: CAGradientLayer {

    override func layoutSublayers() {
        super.layoutSublayers()
        
        frame = super.bounds
    }
}
