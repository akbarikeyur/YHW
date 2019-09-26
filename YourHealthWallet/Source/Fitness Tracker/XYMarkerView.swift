//
//  XYMarkerView.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/17/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Charts

public class XYMarkerView: BalloonMarker {

    public var yAxisValueFormatter: IAxisValueFormatter
    
    fileprivate var yFormatter = NumberFormatter()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                xAxisValueFormatter: IAxisValueFormatter) {
        self.yAxisValueFormatter = xAxisValueFormatter
        yFormatter.minimumFractionDigits = 1
        yFormatter.maximumFractionDigits = 1
        super.init(color: color, font: font, textColor: textColor, insets: insets)
    }
    
    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
         
        let string = yAxisValueFormatter.stringForValue(entry.y, axis: YAxis())
        setLabel(string+" MIN")
    }
}
