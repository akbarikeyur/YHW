//
//  FitnessTrackerStartActivity.swift
//  YourHealthWallet
//
//  Created by Amisha on 3/27/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreMotion
import HealthKit

class FitnessTrackerStartActivity: UIViewController, LocationManagereDelegate {
    
    @IBOutlet weak var gmsMapView: GMSMapView!
    @IBOutlet weak var StartWalkingBtn: Button!
    @IBOutlet weak var headerView: View!
    @IBOutlet weak var walkingView: View!
    @IBOutlet weak var pauseBtnView: UIView!
    @IBOutlet weak var roundView: View!
    @IBOutlet weak var walkingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var subView: View!
    @IBOutlet weak var roundViewTop: NSLayoutConstraint!
    
    var activityType: AddActivityType!
    
    var numberOfSteps:Int! = nil
    
    var distance:Double! = nil
    var pace:Double! = nil
    
    //the pedometer
    var pedometer = CMPedometer()
    
    // timers
    var timer = Timer()
    var timerInterval = 1.0
    var timeElapsed:TimeInterval = 1.0
    
    lazy var updatedLocations = [CLLocation]()
    
    //MARK: - Outlets
    @IBOutlet weak var startPause: UIButton!
    @IBOutlet weak var endBtn: UIButton!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var viewMap: GMSMapView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var milesLabel: UILabel!
    
    private var path = GMSMutablePath()
    private var polyline = GMSPolyline()
    
    var startDate:Date?
    
    var startActivityDate:Date?
    var endActivityDate:Date?
    
    var zeroTime = TimeInterval()
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    
    var isTracking:Bool!
    var currentMarker = GMSMarker()
    var walkerMarker = GMSMarker()
    
    let healthProfileManager = HealthProfileManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        healthProfileManager.readWeightAndHeight()
        //let caloriesPerHour: Double = 450
        let height = healthProfileManager.heightInMeter
        let weight = healthProfileManager.weightInKg

        switch activityType.hashValue {
        case 0:
            self.StartWalkingBtn.setTitle("START WALK", for: .normal)
            self.endBtn.setTitle("END WALK", for: .normal)
            break
        case 1:
            self.StartWalkingBtn.setTitle("START RUN", for: .normal)
            self.endBtn.setTitle("END RUN", for: .normal)
            break
        case 2:
            self.StartWalkingBtn.setTitle("START CYCLE", for: .normal)
            self.endBtn.setTitle("END CYCLE", for: .normal)
            break
        default:
            print("")
        }
        
        isTracking = false
        LocationManager.sharedInstance.delegate = self
        LocationManager.sharedInstance.startUpdatingLocation()
        self.initializePolylineAnnotation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        StartWalkingBtn.isHidden = false
        pauseBtnView.isHidden = true
        walkingView.isHidden = true
        roundView.isHidden = true
    }
    
    func initializePolylineAnnotation() {
        self.polyline.strokeColor = UIColor.blue
        self.polyline.strokeWidth = 5.0
        self.polyline.map = self.viewMap
    }
    
    func tracingLocation(currentLocation: CLLocation) {
        if startLocation == nil {
            startLocation = currentLocation
            
            //Curent marker
            self.currentMarker.icon = UIImage(named:"map-location")
            self.currentMarker.position = (startLocation?.coordinate)!
            self.currentMarker.map = self.viewMap
            self.currentMarker.isTappable = false
            if !isTracking{
                LocationManager.sharedInstance.stopUpdatingLocation()
            }
        }
        // Drawing the line
        self.updateOverlay(currentPosition: currentLocation)
        // Update the map frame
        self.updateMapFrame(newLocation: currentLocation, zoom: 17.0)
        // Update Marker position
        self.updateCurrentPositionMarker(currentLocation: currentLocation)
        lastLocation = currentLocation
    }
    
    func updateOverlay(currentPosition: CLLocation) {
        self.path.add(currentPosition.coordinate)
        self.polyline.path = self.path
    }
    
    func updateMapFrame(newLocation: CLLocation, zoom: Float) {
        let camera = GMSCameraPosition.camera(withTarget: newLocation.coordinate, zoom: zoom)
        self.viewMap.animate(to: camera)
    }
    
    func updateCurrentPositionMarker(currentLocation: CLLocation) {
        self.walkerMarker.icon = UIImage(named:"map-walker")
        self.walkerMarker.position = (currentLocation.coordinate)
        self.walkerMarker.map = self.viewMap
        self.walkerMarker.isTappable = false
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        print("\(error)")
    }
    
    //MARK:- Button Tap
    @IBAction func ClickToBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ClickToStartWalking(_ sender: Any) {
        self.startActivityDate = Date()
        walkingView.isHidden = false
        pauseBtnView.isHidden = false
        StartWalkingBtn.isHidden = true
        roundView.isHidden = false
        
        isTracking = true
        startLocation = nil
        lastLocation = nil
        LocationManager.sharedInstance.startUpdatingLocation()
        self.startDate = Date()
        pedometer = CMPedometer()
        startTimer()
        pedometer.startUpdates(from: self.startDate!, withHandler: { (pedometerData, error) in
            if let pedData = pedometerData{
                self.numberOfSteps = Int(truncating: pedData.numberOfSteps)
                //self.stepsLabel.text = "Steps:\(pedData.numberOfSteps)"
                if let distance = pedData.distance{
                    self.distance = Double(truncating: distance)
                }
                if let currentPace = pedData.currentPace {
                    self.pace = Double(truncating: currentPace)
                }
            } else {
                self.numberOfSteps = nil
            }
        })    }
    
    
    @IBAction func ClickToPause(_ sender: UIButton) {
        
        if sender.isSelected == true{
            pedometer.startUpdates(from: self.startDate!, withHandler: { (pedometerData, error) in
                if let pedData = pedometerData{
                    self.numberOfSteps = Int(truncating: pedData.numberOfSteps)
                    //self.stepsLabel.text = "Steps:\(pedData.numberOfSteps)"
                    if let distance = pedData.distance{
                        self.distance = Double(truncating: distance)
                    }
                    if let currentPace = pedData.currentPace {
                        self.pace = Double(truncating: currentPace)
                    }
                } else {
                    self.numberOfSteps = nil
                }
            })
            isTracking = true
            LocationManager.sharedInstance.startUpdatingLocation()
            startPause.isSelected = false
            timerLabel.text = timeIntervalFormat(interval: timeElapsed)
            startTimer()
        }
        else{
            isTracking = false
            LocationManager.sharedInstance.stopUpdatingLocation()
            pedometer.stopUpdates()
            startPause.isSelected = true
            timerLabel.text = timeIntervalFormat(interval: timeElapsed)
            stopTimer()
            
        }
    }
    
    @IBAction func ClickToEndWalk(_ sender: Any) {
        self.endActivityDate = Date()
        walkingView.isHidden = true
        pauseBtnView.isHidden = true
        StartWalkingBtn.isHidden = false
        roundView.isHidden = true
        isTracking = false
        LocationManager.sharedInstance.stopUpdatingLocation()
        pedometer.stopUpdates()
        stopTimer()
        timerLabel.text = timeIntervalFormat(interval: timeElapsed)
        
        if self.distance == nil {
            self.distance = 0.0
        }
        if self.numberOfSteps == nil {
            self.numberOfSteps = 0
        }
        
        switch activityType.hashValue {
            
        case 0:
            HealthManagerKit.Shared.saveWorkout(workoutType: .walking, workoutStartDate: self.startActivityDate!, workoutEndDate: self.endActivityDate!, workoutDuration: (self.endActivityDate?.timeIntervalSince(self.startActivityDate!))!, workoutEnergyBurned: self.totalEnergyBurned!, workoutTotalDistance: kilometers(meters: self.distance),workoutSteps:Double(self.numberOfSteps)) { (success, error) in
                if success{
//                    AppDelegate.mainWindow().makeToast(kEnterAddedWalk)
                }
                else{
//                    SVProgressHUD.dismiss()
                    AppDelegate.mainWindow().makeToast(error?.localizedDescription)
                }
            }
            break
        case 1:
            HealthManagerKit.Shared.saveWorkout(workoutType: .running, workoutStartDate: self.startActivityDate!, workoutEndDate: self.endActivityDate!, workoutDuration: (self.endActivityDate?.timeIntervalSince(self.startActivityDate!))!, workoutEnergyBurned: self.totalEnergyBurned!, workoutTotalDistance: kilometers(meters: self.distance),workoutSteps:Double(self.numberOfSteps)) { (success, error) in
                if success{
                    //                    AppDelegate.mainWindow().makeToast(kEnterAddedWalk)
                }
                else{
                    //                    SVProgressHUD.dismiss()
                    AppDelegate.mainWindow().makeToast(error?.localizedDescription)
                }        
            }
                break
        case 2:
            HealthManagerKit.Shared.saveWorkout(workoutType: .cycling, workoutStartDate: self.startActivityDate!, workoutEndDate: self.endActivityDate!, workoutDuration: (self.endActivityDate?.timeIntervalSince(self.startActivityDate!))!, workoutEnergyBurned: self.totalEnergyBurned!, workoutTotalDistance: kilometers(meters: self.distance),workoutSteps:Double(self.numberOfSteps)) { (success, error) in
                if success{
                    //                    AppDelegate.mainWindow().makeToast(kEnterAddedWalk)
                }
                else{
                    //                    SVProgressHUD.dismiss()
                    AppDelegate.mainWindow().makeToast(error?.localizedDescription)
                }
                
            }
            break
        default:
            print("")
        }
        let lunchWalkingVC = LunchWalkingVC()
        self.navigationController?.pushViewController(lunchWalkingVC, animated: true)
    }
    
    @IBAction func ClickToRoundBtn(_ sender: Any) {
        if(subView.isHidden){
            walkingViewHeight.constant = 253
            roundViewTop.constant = 176
        }
        else{
            walkingViewHeight.constant = 75
            roundViewTop.constant = 0
        }
        subView.isHidden = !subView.isHidden
    }
    
    //MARK: - timer functions
    func startTimer(){
        if timer.isValid { timer.invalidate() }
        timer = Timer.scheduledTimer(timeInterval: timerInterval,target: self,selector: #selector(timerAction(timer:)) ,userInfo: nil,repeats: true)
    }
    
    func stopTimer(){
        timer.invalidate()
        displayPedometerData()
    }
    
    @objc func timerAction(timer:Timer){
        displayPedometerData()
    }
    
    var totalEnergyBurned: Double? {
        
        //let caloriesPerHour: Double = 450
        let height = healthProfileManager.heightInMeter
        let weight = healthProfileManager.weightInKg

        let a1 = 0.035*weight!
        if let pace = self.pace {
            let valo = pace*pace
            let a2 = valo/height!
            let caloriesPerMin = (a1)+(a2)*0.29*weight!
            return caloriesPerMin
        }else{
            return 0
        }
    }
    // display the updated data
    func displayPedometerData(){
        timeElapsed += 1.0
        timerLabel.text = timeIntervalFormat(interval: timeElapsed)
        
        //Number of steps
        if let numberOfSteps = self.numberOfSteps{
            stepsLabel.text = String(format:"%i",numberOfSteps)
        }
        
        //distance
        if let distance = self.distance{
            distanceLabel.text = String(format:"%02.02f Km",kilometers(meters: distance))
        } else {
            distanceLabel.text = "0 Km"
        }
        
        //pace
        if let pace = self.pace {
            print(pace)
            //paceLabel.text = paceString(title: "Pace:", pace: pace)
        } else {
            //paceLabel.text = "Pace: N/A "
            //paceLabel.text =  paceString(title: "Avg Comp Pace", pace: computedAvgPace())
        }
        
        //distance
        if let caloriest = self.totalEnergyBurned{
            caloriesLabel.text = String(format:"%02.02f Kcal",caloriest)
        } else {
            caloriesLabel.text = "0 Kcal"
        }
    }
    
    //MARK: - Display and time format functions
    
    // convert seconds to hh:mm:ss as a string
    func timeIntervalFormat(interval:TimeInterval)-> String{
        var seconds = Int(interval + 0.5) //round up seconds
        let hours = seconds / 3600
        let minutes = (seconds / 60) % 60
        seconds = seconds % 60
        return String(format:"%02i:%02i:%02i",hours,minutes,seconds)
    }
    
    func paceString(title:String,pace:Double) -> String{
        var minPerMile = 0.0
        let factor = 26.8224 //conversion factor
        if pace != 0 {
            minPerMile = factor / pace
        }
        let minutes = Int(minPerMile)
        let seconds = Int(minPerMile * 60) % 60
        return String(format: "%@: %02.2f m/s ,\t\t %02i:%02i min/mi",title,pace,minutes,seconds)
    }
    
    func computedAvgPace()-> Double {
        if let distance = self.distance{
            pace = distance / timeElapsed
            return pace
        } else {
            return 0.0
        }
    }
    func kilometers(meters:Double)-> Double{
        let km = 1000.0
        return meters / km
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
