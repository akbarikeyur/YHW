//
//  HealthTrackerViewController.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/16/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Charts

enum HealthTrackerType : Int {
    case HeartRate = 0
    case BloodSugar = 1
    case BodyWeight = 2
}

class ChartInfo {
    var xValue: Double
    var xLabel: String
    var yValue: Double
    
    init(xVal: Double, xText: String, yVal: Double) {
        xValue = xVal
        xLabel = xText
        yValue = yVal
    }
}

class HealthTrackerViewController: ViewController {
    
    @IBOutlet weak var collectionView: HealthTrackerCollectionVeiw!
    
    @IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var navigationBarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var heartRateBorder: View!
    @IBOutlet weak var bloodSugarBorder: View!
    @IBOutlet weak var bodyWeightBorder: View!
    
    //Minimum
    @IBOutlet weak var labelMinimumValue: Label!
    @IBOutlet weak var labelMinimumMeasurement: Label!
    
    //Average
    @IBOutlet weak var labelAverageValue: Label!
    @IBOutlet weak var labelAverageMeasurement: Label!
    
    //Maximum
    @IBOutlet weak var labelMaximumValue: Label!
    @IBOutlet weak var labelMaximumMeasurement: Label!
    
    @IBOutlet weak var labelDaysSelectedType: Label!
    @IBOutlet weak var labelSelectedDate: Label!
    
    
    private var selectedHealthTrackerType = HealthTrackerType.HeartRate {
        didSet {
            didChangeHealthTrackerType()
        }
    }
    
    private var selectedDate: Date! = Date() {
        didSet {
            didChangeHealthTrackerType()
        }
    }
    
    private var daysTypes = ["Daily", "Weekly", "Monthly"]
    private var selectedDaysType = 0
    
    private let valuesFont = UIFont(name: "Roboto-Bold", size: 24)!
    private let animationDuration = 3.0
    var chartDataArray = [BarChartDataEntry]()
    var chartDataDict = [Double: ChartInfo]()
    
    init() {
        super.init(nibName: "HealthTrackerViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeHealthTrackerViewController()
        
        barChartView.doubleTapToZoomEnabled = false
        barChartView.pinchZoomEnabled = false
        
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
        
        getHeartRateReading()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationBarHeight.constant = navigationController?.navigationBar.frame.height ?? 40
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getHeartRateReading()
    {
        HeartRateService.callWSForGetHeartRate { (data, error) in
            
        }
    }
    
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnDaysSelectionView(_ sender: UITapGestureRecognizer) {
        DPPickerManager.shared.showPicker(title: nil, selected: daysTypes[selectedDaysType], strings: daysTypes) { (value, index, cancel) in
            if cancel == false && value != nil{
                if index == 2 {
                    self.labelSelectedDate.isHidden = true
                }
                else
                {
                    self.labelSelectedDate.isHidden = false
                }
                
                self.selectedDaysType = index
                self.labelDaysSelectedType.text = value
            }
        }
    }
    
    @IBAction func didTapOnDateLabel(_ sender: UITapGestureRecognizer) {
        if selectedDaysType != 0 {
            return
        }
        let min = Date()
        let max = min.addingTimeInterval(31536000) // 1 year
        DPPickerManager.shared.showPicker(title: "Date Picker", selected: selectedDate, min: min, max: max) { (date, cancel) in
            if cancel == false && date != nil {
                self.selectedDate = date
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                self.labelSelectedDate.text = formatter.string(from: self.selectedDate)
            }
        }
    }
    
    @IBAction func clickToAddReading(_ sender: UIButton) {
        switch selectedHealthTrackerType {
        case .HeartRate:
            let addVC = AddHeartRateReadingVC()
            self.navigationController?.present(addVC, animated: true)
            break
        case .BloodSugar:
            let addVC = AddBloodSugerReadingVC()
            self.navigationController?.present(addVC, animated: true)
            break
        case .BodyWeight:
            let addVC = AddBloodPressureVC(nibName: "AddBloodPressureVC", bundle: nil)
            self.navigationController?.present(addVC, animated: true)
            break
        }
    }
    
}

//MARK: - Private Methods
extension HealthTrackerViewController {
    
    private func initializeHealthTrackerViewController() {
        
        self.selectedHealthTrackerType = .HeartRate
        
        collectionView.didChangeHealtTrackerType = { (healtTrackerType) in
            self.selectedHealthTrackerType = healtTrackerType
        }
    }
    
    func didChangeHealthTrackerType() {
        
        heartRateBorder.isHidden = true
        bloodSugarBorder.isHidden = true
        bodyWeightBorder.isHidden = true
        
        switch selectedHealthTrackerType {
        case .HeartRate:
            heartRateBorder.isHidden = false
            
            let heartRateMeasurement = "bps"
            
            labelMinimumValue.attributedText = getHeartRateAttributedText(text: "65")
            labelMinimumMeasurement.text = heartRateMeasurement
            
            labelAverageValue.attributedText = getHeartRateAttributedText(text: "84")
            labelAverageMeasurement.text = heartRateMeasurement
            
            labelMaximumValue.attributedText = getHeartRateAttributedText(text: "120")
            labelMaximumMeasurement.text = heartRateMeasurement
            
            setHeartRateBarGraphValue()
            break
        case .BloodSugar:
            let bloodSugarMeasurement = "Fasting - Parandial"
            
            bloodSugarBorder.isHidden = false
            
            labelMinimumValue.attributedText = getBloodSugarAttributedText(from: "120", to: "65")
            labelMinimumMeasurement.text = bloodSugarMeasurement
            
            labelAverageValue.attributedText = getBloodSugarAttributedText(from: "180", to: "75")
            labelAverageMeasurement.text = bloodSugarMeasurement
            
            labelMaximumValue.attributedText = getBloodSugarAttributedText(from: "390", to: "200")
            labelMaximumMeasurement.text = bloodSugarMeasurement
            
            setBloodSugarBarGraphValue()
            break
        case .BodyWeight:
            bodyWeightBorder.isHidden = false
            let heartRateMeasurement = "Kg"
            
            labelMinimumValue.attributedText = getBodyWeightAttributedText(text: "65")
            labelMinimumMeasurement.text = heartRateMeasurement
            
            labelAverageValue.attributedText = getBodyWeightAttributedText(text: "84")
            labelAverageMeasurement.text = heartRateMeasurement
            
            labelMaximumValue.attributedText = getBodyWeightAttributedText(text: "120")
            labelMaximumMeasurement.text = heartRateMeasurement
            
            setBodyWeightBarGraphValue()
            break
        }
    }
    
    func getHeartRateAttributedText(text: String) -> NSAttributedString {
        
        let attribute = [
            NSAttributedStringKey.font: valuesFont,
            NSAttributedStringKey.foregroundColor : ColorType.Orange3.value
        ]
        
        let textString = NSMutableAttributedString(string: text, attributes: attribute)
        return textString
    }
    
    func getBloodSugarAttributedText(from: String, to: String) -> NSAttributedString {
        
        let fromAttribute = [
            NSAttributedStringKey.font: valuesFont,
            NSAttributedStringKey.foregroundColor : ColorType.Blue2.value
        ]
        let toAttribute = [
            NSAttributedStringKey.font: valuesFont,
            NSAttributedStringKey.foregroundColor : ColorType.Orange2.value
        ]
        
        let textString = NSMutableAttributedString(string: from + "-", attributes: fromAttribute)
        textString.append(NSAttributedString(string: to, attributes: toAttribute))
        return textString
    }
    
    func getBodyWeightAttributedText(text: String) -> NSAttributedString {
        
        let attribute = [
            NSAttributedStringKey.font: valuesFont,
            NSAttributedStringKey.foregroundColor : ColorType.Green.value
        ]
        
        let textString = NSMutableAttributedString(string: text, attributes: attribute)
        return textString
    }
    
    func setHeartRateBarGraphValue() {

        var chartsInfo = [ChartInfo]()
        
        var time = 12
        
        for i in 1...7 {
            var xText = ""
            
            if i % 2 != 0
            {
                xText = "\(time) PM"
                time += 1
            }
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
        dataSet.colors.append(ColorType.Orange.value) //bar line color
        
        let data = BarChartData(dataSets: [dataSet])
        data.barWidth = 0.1
        
        barChartView.data = data
        
        barChartView.xAxis.valueFormatter = self
        
        //This must stay at end of function
        barChartView.notifyDataSetChanged()
        
        barChartView.animate(yAxisDuration: animationDuration)
    }
    
    func setBloodSugarBarGraphValue() {
        let entry11 = BarChartDataEntry(x: 1.0, y: 30)
        let entry12 = BarChartDataEntry(x: 2.0, y: 50)
        let entry13 = BarChartDataEntry(x: 3.0, y: 100)
        let entry14 = BarChartDataEntry(x: 4.0, y: 80)
        let entry15 = BarChartDataEntry(x: 5.0, y: 70)
        let entry16 = BarChartDataEntry(x: 6.0, y: 30)
        let entry17 = BarChartDataEntry(x: 7.0, y: 70)
        let dataSet1 = BarChartDataSet(values: [entry11, entry12, entry13, entry14, entry15, entry16, entry17], label: nil)
        dataSet1.drawValuesEnabled = false //to hide values
        
        dataSet1.colors.removeAll()
        dataSet1.colors.append(NSUIColor.orange) //bar line color
        
        
        let entry21 = BarChartDataEntry(x: 8.0, y: 70)
        let entry22 = BarChartDataEntry(x: 9.0, y: 90)
        let entry23 = BarChartDataEntry(x: 10.0, y: 30)
        let entry24 = BarChartDataEntry(x: 11.0, y: 40)
        let entry25 = BarChartDataEntry(x: 12.0, y: 70)
        let entry26 = BarChartDataEntry(x: 13.0, y: 120)
        let entry27 = BarChartDataEntry(x: 14.0, y: 40)
        
        let dataSet2 = BarChartDataSet(values: [entry21, entry22, entry23, entry24, entry25, entry26, entry27], label: nil)
        dataSet2.drawValuesEnabled = false //to hide values
        dataSet2.colors.removeAll()
        dataSet2.colors.append(NSUIColor.green) //bar line color
        
        
        let data = BarChartData(dataSets: [dataSet1, dataSet2])
        barChartView.data = data
        
        let groupSpace = 0.68;
        let barSpace = 0.02; // x2 dataset
        let barWidth = 0.25; // x2 dataset
        // (0.02 + 0.45) * 2 + 0.06 = 1.00 -> interval per "group"
        
        data.barWidth = barWidth
        barChartView.groupBars(fromX: 1.0, groupSpace: groupSpace, barSpace: barSpace)
            
        //This must stay at end of function
        barChartView.notifyDataSetChanged()
        
        barChartView.animate(yAxisDuration: animationDuration)
    }
    
    func setBodyWeightBarGraphValue() {
        
        var chartsInfo = [ChartInfo]()
        
        var time = 12
        
        for i in 1...7 {
            var xText = ""
            
            if i % 2 != 0
            {
                xText = "\(time) PM"
                time += 1
            }
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
        dataSet.colors.append(ColorType.Green.value) //bar line color
        
        let data = BarChartData(dataSets: [dataSet])
        data.barWidth = 0.1
        
        barChartView.data = data
        
        barChartView.xAxis.valueFormatter = self
        
        //This must stay at end of function
        barChartView.notifyDataSetChanged()
        
        barChartView.animate(yAxisDuration: animationDuration)
    }
}

extension HealthTrackerViewController : IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let xodeOffset = chartDataDict[value]?.xLabel
        
        return xodeOffset ?? ""
    }
    
    
}
