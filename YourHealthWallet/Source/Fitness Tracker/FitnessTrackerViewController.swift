//
//  FitnessTrackerViewController.swift
//  YourHealthWallet
//
//  Created by Amisha on 3/9/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Charts
import HealthKit

enum AddActivityType{
    case AddWalking
    case AddRunning
    case AddCycling
}
class FitnessTrackerViewController: ViewController, ChartViewDelegate {

    @IBOutlet weak var collView: CollectionView!
    @IBOutlet var chartView: LineChartView!
    @IBOutlet weak var radialViewMonday:RadialProgressView!
    @IBOutlet weak var radialViewTuesday:RadialProgressView!
    @IBOutlet weak var radialViewWednesday:RadialProgressView!
    @IBOutlet weak var radialViewThursday:RadialProgressView!
    @IBOutlet weak var radialViewFriday:RadialProgressView!
    @IBOutlet weak var radialViewSaturday:RadialProgressView!
    @IBOutlet weak var radialViewSunday:RadialProgressView!
    
    var totalMonDuration:Int = 0
    var totalTueDuration:Int = 0
    var totalWedDuration:Int = 0
    var totalThuDuration:Int = 0
    var totalFriDuration:Int = 0
    var totalSatDuration:Int = 0
    var totalSunDuration:Int = 0
    
    var totalMonCalories:Int = 0
    var totalTueCalories:Int = 0
    var totalWedCalories:Int = 0
    var totalThuCalories:Int = 0
    var totalFriCalories:Int = 0
    var totalSatCalories:Int = 0
    var totalSunCalories:Int = 0

    
    var chartDataArray = [ChartDataEntry]()
    var chartDataDict = [Double: ChartInfo]()
    
    var arrHeaderItem: [[String:Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        radialViewMonday.ringProgress = CGFloat(100)

        arrHeaderItem = [["Icon": "PFIttness_Tracker Icon",
                          "goalValue": "21 Jun, 2018",
                          "timeDuration":"12 MIN 56 SEC",
                          "goalType": "Walk"],
                         
                         ["Icon": "",
                          "goalValue": "22 Jun, 2018",
                          "timeDuration":"2.5 KM",
                          "goalType": "Run"],
                         
                         ["Icon": "",
                          "goalValue": "24 Jun, 2018",
                          "timeDuration":"2.5 KM",
                          "goalType": "Cycle"],
                         
                         ["Icon": "",
                          "goalValue": "25 Jun, 2018",
                          "timeDuration":"08 HOURS",
                          "goalType": "Sleep"]
        ]
        
        //Set graph
        self.setGraph()
        
        collView.register(UINib(nibName: String(describing:FitnessTypeCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:FitnessTypeCell.self))
        
        let wieghtTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapAction))
        wieghtTapGestureRecognizer.numberOfTapsRequired = 1
        self.chartView.addGestureRecognizer(wieghtTapGestureRecognizer)
        
        HealthManagerKit.Shared.getBMRCalculation { (bmr) in
            
            print("\(bmr)")
            self.getCalriesFromHealthKit(_bmr: bmr)
        }

    }

    func getCalriesFromHealthKit(_bmr:Int){
        
        //Monday to sunday distanceWalkingRunning
        HealthManagerKit.Shared.getRetriveHealthData(type: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning), startDate: Date().startOfWeek!, endDate: Date().endOfWeek!) { (resultsArray, error) in
            if let myResults = resultsArray {
                for result in myResults as! [HKQuantitySample] {
                    print("Results:\n \(result):---->Startdate:\(result.startDate),Enddate:\(result.endDate),Steps:\(result.quantity.doubleValue(for: HKUnit.mile()))")
                    
                    
                    switch result.startDate.dayNumberOfWeek(){
                    case 1:
                        print("Sunday duration:\(result.endDate.timeIntervalSince(result.startDate))")
                        self.totalSunDuration += Int(getTotalMinutesFromInteval(interval: result.endDate.timeIntervalSince(result.startDate)))
                        break
                    case 2:
                        print("Monday duration:\(result.endDate.timeIntervalSince(result.startDate))")
                        self.totalMonDuration += Int(getTotalMinutesFromInteval(interval: result.endDate.timeIntervalSince(result.startDate)))
                        break
                    case 3:
                        print("Tuesday duration:\(result.endDate.timeIntervalSince(result.startDate))")
                        self.totalTueDuration += Int(getTotalMinutesFromInteval(interval: result.endDate.timeIntervalSince(result.startDate)))
                        break
                    case 4:
                        print("Wednesday duration:\(result.endDate.timeIntervalSince(result.startDate))")
                        self.totalWedDuration += Int(getTotalMinutesFromInteval(interval: result.endDate.timeIntervalSince(result.startDate)))
                        break
                    case 5:
                        print("Thursday duration:\(result.endDate.timeIntervalSince(result.startDate))")
                        self.totalThuDuration += Int(getTotalMinutesFromInteval(interval: result.endDate.timeIntervalSince(result.startDate)))
                        break
                    case 6:
                        print("Friday duration:\(result.endDate.timeIntervalSince(result.startDate))")
                        self.totalFriDuration += Int(getTotalMinutesFromInteval(interval: result.endDate.timeIntervalSince(result.startDate)))
                        break
                    case 7:
                        print("Saturday duration:\(result.endDate.timeIntervalSince(result.startDate))")
                        self.totalSatDuration += Int(getTotalMinutesFromInteval(interval: result.endDate.timeIntervalSince(result.startDate)))
                        break
                    default:
                        print("")
                    }
                }
                
                self.totalMonCalories = (_bmr * Int(5.0/24)) * (self.totalMonDuration)
                print(self.totalMonCalories)
            }
        }
    }
    
    func setGraph()
    {
        chartView.doubleTapToZoomEnabled = false
        chartView.pinchZoomEnabled = false
        chartView.scaleXEnabled = true
        chartView.delegate = self
        chartView.borderLineWidth = 0.0
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .bottom
        
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.xAxis.valueFormatter = self

        chartView.chartDescription?.text = ""
        
        chartView.legend.enabled = false //this is for hiding guide colors.
        
        //set chart
        self.setLineGraphValue()
    }
    
    @objc func myTapAction(recognizer: UITapGestureRecognizer) {
        let weightVC = FitnessTrackerWeightVC()
        self.navigationController?.pushViewController(weightVC, animated: true)
        
    }

    func setLineGraphValue() {
        
        var chartsInfo = [ChartInfo]()
        
        let months = ["DEC", "JAN", "FEB",
                      "MAR", "APR", "MAY",
                      "JUN","JUL","AUG","SEP","OCT","NOV"]
        
        for (index, item) in months.enumerated() {
            let data = ChartInfo(xVal: Double(index), xText: item, yVal: Double(arc4random_uniform(100)))
            chartsInfo.append(data)
            chartDataDict[Double(index)] = data
        }
        
        chartDataArray.removeAll()
        for info in chartsInfo {
            chartDataArray.append(ChartDataEntry(x: info.xValue, y: info.yValue))
        }
        
        let dataSet = LineChartDataSet(values: chartDataArray, label: nil)
        dataSet.drawIconsEnabled = false
        
        dataSet.setColor(.blue)
        dataSet.setCircleColor(.red)
        dataSet.lineWidth = 1
        dataSet.circleRadius = 3
        dataSet.drawCircleHoleEnabled = true
        dataSet.valueFont = .systemFont(ofSize: 9)
        dataSet.formLineWidth = 1
        dataSet.formSize = 15
        dataSet.mode = .cubicBezier
        
        let gradientColors = [ChartColorTemplates.colorFromString("#ffffff").cgColor,
                              ChartColorTemplates.colorFromString("#0000ff").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        dataSet.fillAlpha = 1
        dataSet.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        dataSet.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: dataSet)
        
        chartView.data = data
        chartView.setVisibleXRangeMaximum(7)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
}
extension FitnessTrackerViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:FitnessTypeCell.self), for: indexPath) as! FitnessTypeCell
        
        
        switch indexPath.item {
        case 0:
            cell.backContentView.gradientBackgroundType = GradientColorType.HealthTrackerOrange
        case 1:
            cell.backContentView.gradientBackgroundType = GradientColorType.MedicationsPurpule
        case 2:
            cell.backContentView.gradientBackgroundType = GradientColorType.FitnessTrackerCycleSkye
        case 3:
            cell.backContentView.gradientBackgroundType = GradientColorType.FitnessTrackerSleepColor
        default:
            print("")
        }
        cell.goalImageIcon.image = UIImage.init(named: arrHeaderItem[indexPath.item]["Icon"] as! String)
        

        cell.lblTime.text = arrHeaderItem[indexPath.item]["goalValue"] as? String
        cell.lblFitnessItemName.text = arrHeaderItem[indexPath.item]["goalType"] as? String
        
        cell.lblDetail.text = arrHeaderItem[indexPath.item]["timeDuration"] as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict = ["message" : indexPath.item + 1]
        
        NotificationCenter.default.post(name: NSNotification.Name("NotificationMessageEvent"), object: nil, userInfo: dict)
    }
}
extension FitnessTrackerViewController : IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let xodeOffset = chartDataDict[value]?.xLabel
        
        return xodeOffset ?? ""
    }
    
    
}
