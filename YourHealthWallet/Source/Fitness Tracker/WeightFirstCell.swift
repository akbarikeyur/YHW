//
//  WeightFirstCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 5/01/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Charts

class WeightFirstCell: TableViewCell, ChartViewDelegate {
    
    @IBOutlet weak var barChartView: CombinedChartView!
    @IBOutlet weak var viewStackType: UIStackView!
    
    @IBOutlet  var gaugeViewHead:WMGaugeView!
    
    private var daysTypes = ["Today", "Weekly"]
    private var selectedDaysType = 0
    
    private let valuesFont = UIFont(name: "Roboto-Bold", size: 24)!
    private let animationDuration = 3.0
    var chartDataArray = [BarChartDataEntry]()
    var chartDataEntreisArray = [ChartDataEntry]()

    var chartDataDict = [Double: ChartInfo]()
    
    var currentDate : String!
    @IBOutlet weak var labelDaysSelectedType: Label!
    @IBOutlet weak var labelSelectedDate: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        barChartView.doubleTapToZoomEnabled = false
        barChartView.pinchZoomEnabled = false
        barChartView.scaleXEnabled = true
        barChartView.delegate = self
        barChartView.borderLineWidth = 0.0
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelPosition = .bottom
        
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        
        barChartView.chartDescription?.text = ""
        
        barChartView.legend.enabled = false //this is for hiding guide colors.
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewStackType.addGestureRecognizer(gestureRecognizer)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        currentDate = formatter.string(from: Date())
        self.labelSelectedDate.text = self.currentDate
        
        // Initialization code
        setTodayBarGraphValue()
        setWeightMeter()
    }
    
    func setWeightMeter()
    {
        DispatchQueue.main.async {
            
            self.gaugeViewHead.needleStyle = WMGaugeViewNeedleStyleFlatThin
            self.gaugeViewHead.maxValue = 270.0
            self.gaugeViewHead.scaleDivisions = 10
            self.gaugeViewHead.scaleStartAngle = 90
            self.gaugeViewHead.showRangeLabels = false
            self.gaugeViewHead.scaleEndAngle = 270
            self.gaugeViewHead.rangeValues = [78]
            self.gaugeViewHead.rangeColors = [UIColor.yellow]
            self.gaugeViewHead.needleHeight = 0.2
            self.gaugeViewHead.needleScrewRadius = 0.02
            self.gaugeViewHead.needleWidth = 0.008
            self.gaugeViewHead.needleScrewStyle = WMGaugeViewNeedleScrewStylePlain
            self.gaugeViewHead.needleColor = UIColor.white
            self.gaugeViewHead.needleScrewColor = UIColor.white
            self.gaugeViewHead.showUnitOfMeasurement = false
            self.gaugeViewHead.scaleDivisionsWidth = 0.008;
            self.gaugeViewHead.scaleSubdivisionsWidth = 0.010;
            self.gaugeViewHead.scaleSubDivisionColor = UIColor.white
            self.gaugeViewHead.scaleDivisionColor = UIColor.white
            self.gaugeViewHead.showInnerRim = false
            self.gaugeViewHead.showInnerBackground = false
            self.gaugeViewHead.setValue(78, animated: true, duration: 0.5)
        }

    }
    
    @objc func updateTimer() {
       // self.gaugeViewHead.value = arc4random()%(Int)gaugeViewHead.maxValue
        gaugeViewHead.value = Float(Int(arc4random()) % Int(gaugeViewHead.maxValue))
    }
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        DPPickerManager.shared.showPicker(title: nil, selected: daysTypes[selectedDaysType], strings: daysTypes) { (value, index, cancel) in
            if cancel == false && value != nil{
                
                if index == 1 {
                    
                    //let weakDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())
                    self.setWeeklyBarGraphValue()
                    self.labelSelectedDate.text = "THU 21-27 MAR, 2018"
                }
                else
                {
                    self.setTodayBarGraphValue()
                    self.labelSelectedDate.text = self.currentDate
                }
                
                self.selectedDaysType = index
                self.labelDaysSelectedType.text = value
            }
        }
    }
    
    func setTodayBarGraphValue() {
        
        var chartsInfo = [ChartInfo]()
        
        let timeX = ["12 AM", "1 AM", "2 AM","3 AM","4 AM","5 AM","6 AM","7 AM","8 AM","9 AM","10 AM","11 AM","12 PM","1 PM","2 PM","3 PM","4 PM","5 PM","6 PM","7 PM","8 PM","9 PM","10 PM","11 PM",
                     ]
        for (index, item) in timeX.reversed().enumerated() {
            let data = ChartInfo(xVal: Double(index), xText: item, yVal: Double(arc4random_uniform(100)))
            chartsInfo.append(data)
            chartDataDict[Double(index)] = data
        }
        
        chartDataArray.removeAll()
        for info in chartsInfo {
            chartDataArray.append(BarChartDataEntry(x: info.xValue, y: info.yValue))
        }
        
        chartDataEntreisArray.removeAll()
        for info in chartsInfo {
            chartDataEntreisArray.append(ChartDataEntry(x: info.xValue, y: info.yValue))
        }
        
        let dataSet = LineChartDataSet(values: chartDataEntreisArray, label: nil)
        dataSet.drawValuesEnabled = false //to hide values
        dataSet.colors.removeAll()
        dataSet.setColor(UIColor(red:0.94, green:0.19, blue:0.76, alpha:1))
        dataSet.circleColors = [UIColor.red]
        dataSet.circleHoleColor = UIColor.red
        dataSet.lineWidth = 2.5
        dataSet.circleRadius = 5
        dataSet.circleHoleRadius = 2.5
        dataSet.fillColor = UIColor.red
        dataSet.mode = .linear
        dataSet.axisDependency = .right
        let data = LineChartData(dataSets: [dataSet])
        
        
        let dataSet2 = BarChartDataSet(values: chartDataArray, label: nil)
        dataSet2.drawValuesEnabled = false //to hide values
        dataSet2.colors.removeAll()
        dataSet2.colors.append(ColorType.Gray.value) //bar line color
        
        let data2 = BarChartData(dataSets: [dataSet2])
        data2.barWidth = 0.05
        
        
        let doubleData = CombinedChartData()
        doubleData.lineData = data
        doubleData.barData = data2
        barChartView.data = doubleData
        barChartView.setVisibleXRangeMaximum(7)

        barChartView.xAxis.valueFormatter = self
        
        //This must stay at end of function
        barChartView.notifyDataSetChanged()
        
        barChartView.animate(yAxisDuration: animationDuration)
         let marker = XYChartWeightMarker(color: UIColor(red:0.94, green:0.19, blue:0.76, alpha:1), font: UIFont(name: "Roboto-Bold", size: 11)!, textColor: .white, insets: UIEdgeInsets(top: 5, left: 5, bottom: 15, right: 5), yAxisValueFormatter: barChartView.rightAxis.valueFormatter!)

        marker.chartView = barChartView
        marker.minimumSize = CGSize(width: 50, height: 30)
        barChartView.marker = marker
    }
    
    func setWeeklyBarGraphValue() {
        
        var chartsInfo = [ChartInfo]()
        
        let months = ["MON", "TUE", "WED",
                      "THU", "FRI", "SAT",
                      "SUN"]
        for i in 0...6 {
            let xText = months[i]
            
            let data = ChartInfo(xVal: Double(i), xText: xText, yVal: Double(arc4random_uniform(100)))
            chartsInfo.append(data)
            chartDataDict[Double(i)] = data
        }
        
        chartDataArray.removeAll()
        for info in chartsInfo {
            chartDataArray.append(BarChartDataEntry(x: info.xValue, y: info.yValue))
        }
        
        chartDataEntreisArray.removeAll()
        for info in chartsInfo {
            chartDataEntreisArray.append(ChartDataEntry(x: info.xValue, y: info.yValue))
        }
        
        let dataSet = LineChartDataSet(values: chartDataEntreisArray, label: nil)
        dataSet.drawValuesEnabled = false //to hide values
        dataSet.colors.removeAll()
        dataSet.setColor(UIColor(red:0.94, green:0.19, blue:0.76, alpha:1))
        dataSet.circleColors = [UIColor.red]
        dataSet.circleHoleColor = UIColor.red
        dataSet.lineWidth = 2.5
        dataSet.circleRadius = 5
        dataSet.circleHoleRadius = 2.5
        dataSet.fillColor = UIColor.red
        dataSet.mode = .linear
        dataSet.axisDependency = .right
        let data = LineChartData(dataSets: [dataSet])
        
        
        let dataSet2 = BarChartDataSet(values: chartDataArray, label: nil)
        dataSet2.drawValuesEnabled = false //to hide values
        dataSet2.colors.removeAll()
        dataSet2.colors.append(ColorType.Gray.value) //bar line color
        
        let data2 = BarChartData(dataSets: [dataSet2])
        data2.barWidth = 0.05
        
        barChartView.fitScreen()
        let doubleData = CombinedChartData()
        doubleData.lineData = data
        doubleData.barData = data2
        barChartView.data = doubleData
        
        barChartView.xAxis.valueFormatter = self
        
        //This must stay at end of function
        barChartView.notifyDataSetChanged()
        
        barChartView.animate(yAxisDuration: animationDuration)
        let marker = XYChartWeightMarker(color: UIColor(red:0.94, green:0.19, blue:0.76, alpha:1), font: UIFont(name: "Roboto-Bold", size: 11)!, textColor: .white, insets: UIEdgeInsets(top: 5, left: 5, bottom: 15, right: 5), yAxisValueFormatter: barChartView.rightAxis.valueFormatter!)
        
        marker.chartView = barChartView
        marker.minimumSize = CGSize(width: 50, height: 30)
        barChartView.marker = marker
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension WeightFirstCell : IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let xodeOffset = chartDataDict[value]?.xLabel
        
        return xodeOffset ?? ""
    }
    
    
}
