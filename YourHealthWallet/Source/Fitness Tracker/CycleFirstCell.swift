//
//  CycleFirstCell.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/19/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Charts
import HealthKit

protocol GetCycleDayTypeDelegate:class {
    func getCycleDayType(selectedDaysType:Int)
}

class CycleFirstCell: TableViewCell {
    
    @IBOutlet weak var lblHour: Label!
    @IBOutlet weak var lblMinute: Label!
    @IBOutlet weak var lblSecond: Label!
    @IBOutlet weak var lblKilometer: Label!
    @IBOutlet weak var lblCalories: Label!
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var viewStackType: UIStackView!
    
    private var daysTypes = ["Today", "Weekly"]
    private var selectedDaysType = 0
    
    weak var delegate: GetCycleDayTypeDelegate?

    private let valuesFont = UIFont(name: "Roboto-Bold", size: 24)!
    private let animationDuration = 3.0
    var chartDataArray = [BarChartDataEntry]()
    var chartDataDict = [Double: ChartInfo]()
    
    var chartXValues = [String]()
    var chartYValues = [Double]()

    var currentDate : String!
    @IBOutlet weak var labelDaysSelectedType: Label!
    @IBOutlet weak var labelSelectedDate: Label!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        viewStackType.addGestureRecognizer(gestureRecognizer)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        currentDate = formatter.string(from: Date())
        self.labelSelectedDate.text = self.currentDate

    }
    
    func setCalculateCycleData(firstCellWorkouts:[HKWorkout]?){
        self.chartXValues = []
        self.chartYValues = []
        
        if let workouts = firstCellWorkouts{
            var hours:Int = 0
            var minuts:Int = 0
            var seconds:Int = 0
            var calories:Double = 0
            var totalDistance:Double = 0
            for (index, item) in workouts.enumerated() {
                hours += Int(getHourFromInteval(interval: item.duration))
                minuts += Int(getMinutesFromInteval(interval: item.duration))
                seconds += Int(getSecondsFromInteval(interval: item.duration))
                calories += (item.totalEnergyBurned?.doubleValue(for: HKUnit.kilocalorie()))!
                totalDistance += (item.totalDistance?.doubleValue(for: HKUnit.mile()))!
                if selectedDaysType == 0{
                    self.chartXValues.append(item.startDate.toString(format: .custom(DATE_FORMAT.CHART_X_FORMATE_DAY)))
                }
                else{
                    self.chartXValues.append(item.startDate.toString(format: .custom(DATE_FORMAT.CHART_X_FORMATE_WEEK)))
                    
                }
                self.chartYValues.append(Double(getTotalMinutesFromInteval(interval: item.duration)))
            }
            
            lblHour.text = String(format: "%0.2d", hours)
            lblMinute.text = String(format: "%0.2d", minuts)
            lblSecond.text = String(format: "%0.2d", seconds)
            lblCalories.text = String(format: "%0.0f", calories)
            lblKilometer.text = String(format:"%0.0f KM",(totalDistance*1.609344))
            
            if selectedDaysType == 0{
                barChartView.clear()
                setTodayBarGraphValue()
            }else{
                barChartView.clear()
                self.setWeeklyBarGraphValue()
            }
        }
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        DPPickerManager.shared.showPicker(title: nil, selected: daysTypes[selectedDaysType], strings: daysTypes) { (value, index, cancel) in
            if cancel == false && value != nil{
                
                if index == 1 {
                    
                    self.labelSelectedDate.text = (Date().startOfWeek?.toString(format: .custom(DATE_FORMAT.WEEKDAY_CHART_START)))!+"-"+(Date().endOfWeek?.toString(format: .custom(DATE_FORMAT.WEEKDAY_CHART_END)))!
                }
                else
                {
                    self.labelSelectedDate.text = self.currentDate
                }
                self.selectedDaysType = index

                self.delegate?.getCycleDayType(selectedDaysType: index)
                self.labelDaysSelectedType.text = value
            }
        }
    }
    
    func setTodayBarGraphValue() {
        
        if self.chartXValues.count > 0{
            
            var chartsInfo = [ChartInfo]()
            
            for (index, item) in self.chartXValues.enumerated() {
                let data = ChartInfo(xVal: Double(index), xText: item, yVal: Double(self.chartYValues[index]))
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
            dataSet.colors.append(ColorType.FitnessCycleSkyeColor.value) //bar line color
            
            let data = BarChartData(dataSets: [dataSet])
            data.barWidth = 0.1
            
            barChartView.data = data
            barChartView.setVisibleXRangeMaximum(7)
            
            barChartView.xAxis.valueFormatter = self
            
            //This must stay at end of function
            barChartView.notifyDataSetChanged()
            
            barChartView.animate(yAxisDuration: animationDuration)
            let marker = XYMarkerView(color: FitnessTrackerCycleSkyeColor,
                                      font: UIFont(name: "Roboto-Bold", size: 11)!,
                                      textColor: .white,
                                      insets: UIEdgeInsets(top: 5, left: 5, bottom: 15, right: 5),
                                      xAxisValueFormatter: barChartView.leftAxis.valueFormatter!)
            
            marker.chartView = barChartView
            marker.minimumSize = CGSize(width: 50, height: 30)
            barChartView.marker = marker
        }
    }
    
    func setWeeklyBarGraphValue() {
        
        if self.chartXValues.count > 0{
            
            var chartsInfo = [ChartInfo]()
            
            for (index, item) in self.chartXValues.enumerated() {
                let data = ChartInfo(xVal: Double(index), xText: item, yVal: Double(self.chartYValues[index]))
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
            dataSet.colors.append(ColorType.FitnessCycleSkyeColor.value) //bar line color
            
            let data = BarChartData(dataSets: [dataSet])
            data.barWidth = 0.1
            barChartView.fitScreen()
            barChartView.data = data
            
            barChartView.xAxis.valueFormatter = self
            
            //This must stay at end of function
            barChartView.notifyDataSetChanged()
            
            barChartView.animate(yAxisDuration: animationDuration)
            
            let marker = XYMarkerView(color: FitnessTrackerCycleSkyeColor,
                                      font: UIFont(name: "Roboto-Bold", size: 11)!,
                                      textColor: .white,
                                      insets: UIEdgeInsets(top: 5, left: 5, bottom: 15, right: 5),
                                      xAxisValueFormatter: barChartView.leftAxis.valueFormatter!)
            
            marker.chartView = barChartView
            marker.minimumSize = CGSize(width: 50, height: 30)
            barChartView.marker = marker
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension CycleFirstCell : IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let xodeOffset = chartDataDict[value]?.xLabel
        
        return xodeOffset ?? ""
    }
    
    
}
