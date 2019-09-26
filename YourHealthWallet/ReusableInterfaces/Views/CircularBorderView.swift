//
//  CircularBorderView.swift
//  YourHealthWallet
//
//  Created by Shridhar on 24/02/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class CircularBorderView: View {

    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        let radius = self.bounds.width * 0.5 - 2.0
        let topAngle = CGFloat(-Double.pi/2)
        let bottomAngle = CGFloat(Double.pi / 2)
        let lineWidth: CGFloat = 4.0
        
        
        let rightSideHalf = UIBezierPath(arcCenter: center, radius: radius, startAngle: topAngle, endAngle: bottomAngle, clockwise: true)
        rightSideHalf.lineWidth = lineWidth
        ColorType.Gray2.value.setStroke()
        rightSideHalf.stroke()
        
        let leftSideHalf = UIBezierPath(arcCenter: center, radius: radius, startAngle: bottomAngle, endAngle: topAngle, clockwise: true)
        leftSideHalf.lineWidth = lineWidth
        ColorType.Yellow2.value.setStroke()
        leftSideHalf.stroke()
    }

}
