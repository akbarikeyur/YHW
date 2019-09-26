//
//  FitnessTrackerCycleVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/19/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import HealthKit

class FitnessTrackerCycleVC: ViewController, GetCycleDayTypeDelegate {
    
    @IBOutlet weak var tblListView: TableView!
    
    var workouts: [HKWorkout]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register cell
        tblListView.register(UINib(nibName: String(describing: CycleListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CycleListCell.self))
        
        tblListView.register(UINib(nibName: String(describing: CycleFirstCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CycleFirstCell.self))
        
        self.getCycleDayType(selectedDaysType: 0)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //Delegate day
    func getCycleDayType(selectedDaysType: Int) {
        if selectedDaysType == 1{
            HealthManagerKit.loadWorkoutsData(workoutActivityType:.cycling) { (workouts, error) in
                let filterItems = workouts?.filter{item in return item.startDate.compare(.isThisWeek)}
                
                self.workouts = filterItems
                self.tblListView.reloadData()
            }
        }else{
            
            HealthManagerKit.loadWorkoutsData(workoutActivityType:.cycling) { (workouts, error) in
                let filterItems = workouts?.filter{item in return item.startDate.compare(.isToday)}
                
                self.workouts = filterItems
                self.tblListView.reloadData()
            }
        }
    }
    
    @IBAction func didTapOnAdd(_ sender: Button) {
        
        self.showPopup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension FitnessTrackerCycleVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0){
            return 1
        }else{
            guard let workouts = workouts else {
                return 0
            }
            
            return workouts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let cycleFirstCell = tableView.dequeueReusableCell(withIdentifier: String(describing: CycleFirstCell.self)) as! CycleFirstCell
            cycleFirstCell.delegate = self
            cycleFirstCell.setCalculateCycleData(firstCellWorkouts: self.workouts)
            return cycleFirstCell
        }
        else{
            let cycleListCell = tableView.dequeueReusableCell(withIdentifier: String(describing: CycleListCell.self)) as! CycleListCell
            let workout = workouts![indexPath.row]
            cycleListCell.lblTime.text = workout.startDate.toString(format: .custom(DATE_FORMAT.MEDICATION_TIME))
            cycleListCell.lblDuration.text = stringFromTimeInterval(interval: workout.duration)
            return cycleListCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
extension FitnessTrackerCycleVC:UIPopoverPresentationControllerDelegate,PopUpHideWithActionDelegate
{
    func showPopup()
    {
        let arrHeaderItem = [["Title": "Start Activity", "Icon": "start-activity"],
                             ["Title": "Add Activity", "Icon": "add-activity"]]
        
        let popUpVC = PopOverViewController.init(arrItems: arrHeaderItem)
        popUpVC.delegate = self
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.modalTransitionStyle = .crossDissolve
        popUpVC.preferredContentSize = CGSize.init(width: 200, height: 200)
        let pVC = popUpVC.popoverPresentationController
        pVC?.permittedArrowDirections = .any
        pVC?.delegate = self
        pVC?.sourceView = UIView()
        pVC?.sourceRect = CGRect.init(x: 100, y: 100, width: 1, height: 1)
        pVC?.backgroundColor = UIColor.black
        
        self.navigationController?.present(popUpVC, animated: true, completion: nil)
    }
    
    func hideWithIndex(index: NSInteger) {
        switch index {
        case 0:
            let addActivityVC = FitnessTrackerStartActivity()
            addActivityVC.activityType = AddActivityType.AddCycling
            self.navigationController?.pushViewController(addActivityVC, animated: true)
            break
        case 1:
            let addActivityVC = AddActivityWalkRunCycleVC()
            addActivityVC.activityType = AddActivityType.AddCycling
            self.present(addActivityVC, animated: true, completion: nil)
            break
        default:
            break
        }
        
    }
}
