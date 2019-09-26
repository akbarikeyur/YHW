//
//  SleepFirstCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/20/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

import UIKit
import Charts
import HGCircularSlider
import HealthKit

protocol SleepManualShowHideDelegate: class {
    func showHide(isHide:Bool,reloadIndex:IndexPath)
    func getSleepDayType(selectedDaysType:Int)
}

class SleepFirstCell: TableViewCell {
    
    weak var delegate: SleepManualShowHideDelegate?

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var viewStackType: UIStackView!
    
    private var daysTypes = ["Daily", "Weekly"]
    private var selectedDaysType = 0
    
    private let valuesFont = UIFont(name: "Roboto-Bold", size: 24)!
    private let animationDuration = 3.0
    var chartDataArray = [BarChartDataEntry]()
    var chartDataDict = [Double: ChartInfo]()
    
    var chartXValues = [String]()
    var chartYValues = [Double]()
    
    var currentDate : String!
    @IBOutlet weak var labelDaysSelectedType: Label!
    @IBOutlet weak var labelSelectedDate: Label!
    @IBOutlet weak var lblSleepInfo: Label!

    @IBOutlet weak var durationLabel: Label!
    @IBOutlet weak var rangeCircularSlider: RangeCircularSlider!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Set Graph
        setGraph()
        
        //Set Clock
        durationLabel.text = ("\(00)h:\(00)m")
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewStackType.addGestureRecognizer(gestureRecognizer)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        currentDate = formatter.string(from: Date())
        self.labelSelectedDate.text = self.currentDate
        
        
        setTodayBarGraphValue()
        // Initialization code
    }
    
    
    func setCalculateSleepData(firstCellWorkouts:[HKSample]?){
        
        if let workouts = firstCellWorkouts{
            for (_, item) in workouts.enumerated() {
                let myGoBedTime = item.startDate
                let myWeakUpTime = item.endDate
                let mySleepTime = myWeakUpTime.timeIntervalSince(myGoBedTime)
                
                DispatchQueue.main.async {
                    let hour = getHourFromInteval(interval: mySleepTime)
                    let min = getMinutesFromInteval(interval: mySleepTime)
                    let total:CGFloat = CGFloat(Float(String(format: "%d.%0.2d",hour, min))!)
                    
                    
                    self.rangeCircularSlider.startThumbImage = UIImage(named: "Bedtime")
                    self.rangeCircularSlider.endThumbImage = UIImage(named: "Wake")
                    
                    self.rangeCircularSlider.isUserInteractionEnabled = false
                    
                    let dayInSeconds = 24 * 60 * 60
                    self.rangeCircularSlider.maximumValue = CGFloat(dayInSeconds)
                    
                    self.rangeCircularSlider.startPointValue = 0 * 60 * 60
                    self.rangeCircularSlider.endPointValue = CGFloat(hour * 60 * 60)
                    self.durationLabel.text = ("\(hour)h:\(min)m")
                }
            }
            if selectedDaysType == 0{
                // Initialization code
                barChartView.clear()
                setTodayBarGraphValue()
            }else{
                barChartView.clear()
                self.setWeeklyBarGraphValue()
            }
        }
    }
    
    func setGraph()
    {
        barChartView.doubleTapToZoomEnabled = false
        barChartView.pinchZoomEnabled = false
        barChartView.scaleXEnabled = true
        
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
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        DPPickerManager.shared.showPicker(title: nil, selected: daysTypes[selectedDaysType], strings: daysTypes) { (value, index, cancel) in
            if cancel == false && value != nil{
                
                if index == 1 {
                    
                    self.labelSelectedDate.text = (Date().startOfWeek?.toString(format: .custom(DATE_FORMAT.WEEKDAY_CHART_START)))!+"-"+(Date().endOfWeek?.toString(format: .custom(DATE_FORMAT.WEEKDAY_CHART_END)))!
                    self.delegate?.showHide(isHide: false,reloadIndex:IndexPath(row: 0, section: 2))
                    
                    self.lblSleepInfo.text = "Average Sleep"
                }
                else
                {
                    self.labelSelectedDate.text = self.currentDate
                    self.delegate?.showHide(isHide: true,reloadIndex:IndexPath(row: 0, section: 2))
                
                    self.lblSleepInfo.text = "Total Sleep"
                }
                
                self.selectedDaysType = index
                self.delegate?.getSleepDayType(selectedDaysType: index)
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
        
        let dataSet = BarChartDataSet(values: chartDataArray, label: nil)
        dataSet.drawValuesEnabled = false //to hide values
        dataSet.colors.removeAll()
        dataSet.colors.append(ColorType.FitnessSleepColor.value) //bar line color
        
        let data = BarChartData(dataSets: [dataSet])
        data.barWidth = 0.1
        
        barChartView.data = data
        barChartView.setVisibleXRangeMaximum(7)
        barChartView.xAxis.valueFormatter = self
        
        //This must stay at end of function
        barChartView.notifyDataSetChanged()
        
        barChartView.animate(yAxisDuration: animationDuration)
        let marker = XYMarkerView(color: FitnessTrackerSleepColor,
                                  font: UIFont(name: "Roboto-Bold", size: 11)!,
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 5, left: 5, bottom: 15, right: 5),
                                  xAxisValueFormatter: barChartView.xAxis.valueFormatter!)
        
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
        
        let dataSet = BarChartDataSet(values: chartDataArray, label: nil)
        dataSet.drawValuesEnabled = false //to hide values
        dataSet.colors.removeAll()
        dataSet.colors.append(ColorType.FitnessSleepColor.value) //bar line color
        
        let data = BarChartData(dataSets: [dataSet])
        data.barWidth = 0.1
        barChartView.fitScreen()
        barChartView.data = data
        
        barChartView.xAxis.valueFormatter = self
        
        //This must stay at end of function
        barChartView.notifyDataSetChanged()
        
        barChartView.animate(yAxisDuration: animationDuration)
        
        let marker = XYMarkerView(color: FitnessTrackerSleepColor,
                                  font: UIFont(name: "Roboto-Bold", size: 11)!,
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 5, left: 5, bottom: 15, right: 5),
                                  xAxisValueFormatter: barChartView.xAxis.valueFormatter!)
        
        marker.chartView = barChartView
        marker.minimumSize = CGSize(width: 50, height: 30)
        barChartView.marker = marker
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
}
extension SleepFirstCell : IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let xodeOffset = chartDataDict[value]?.xLabel
        
        return xodeOffset ?? ""
    }
    
    
}
