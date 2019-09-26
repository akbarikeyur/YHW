//
//  FitnessTrackerRunVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/19/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import HealthKit

class FitnessTrackerRunVC: ViewController,GetRunDayTypeDelegate {
    
    @IBOutlet weak var tblListView: TableView!
    
    var workouts: [HKWorkout]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register cell
        tblListView.register(UINib(nibName: String(describing: RunListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RunListCell.self))
        
        tblListView.register(UINib(nibName: String(describing: RunFirstCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RunFirstCell.self))
        
        self.getRunDayType(selectedDaysType: 0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //Delegate day
    func getRunDayType(selectedDaysType: Int) {
        if selectedDaysType == 1{
            HealthManagerKit.loadWorkoutsData(workoutActivityType:.running) { (workouts, error) in
                let filterItems = workouts?.filter{item in return item.startDate.compare(.isThisWeek)}
                
                self.workouts = filterItems
                self.tblListView.reloadData()
            }
        }else{
            
            HealthManagerKit.loadWorkoutsData(workoutActivityType:.running) { (workouts, error) in
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

extension FitnessTrackerRunVC : UITableViewDelegate, UITableViewDataSource
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
            let walkFirstCell = tableView.dequeueReusableCell(withIdentifier: String(describing: RunFirstCell.self)) as! RunFirstCell
            walkFirstCell.delegate = self
            walkFirstCell.setCalculateRunData(firstCellWorkouts: self.workouts)
            
            return walkFirstCell
        }
        else{
            let walkListCell = tableView.dequeueReusableCell(withIdentifier: String(describing: RunListCell.self)) as! RunListCell
            let workout = workouts![indexPath.row]
            walkListCell.lblTime.text = workout.startDate.toString(format: .custom(DATE_FORMAT.MEDICATION_TIME))
            walkListCell.lblDuration.text = stringFromTimeInterval(interval: workout.duration)
            return walkListCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
extension FitnessTrackerRunVC:UIPopoverPresentationControllerDelegate,PopUpHideWithActionDelegate
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
            addActivityVC.activityType = AddActivityType.AddRunning
            self.navigationController?.pushViewController(addActivityVC, animated: true)
            break
        case 1:
            let addActivityVC = AddActivityWalkRunCycleVC()
            addActivityVC.activityType = AddActivityType.AddRunning
            self.present(addActivityVC, animated: true, completion: nil)
            break
        default:
            break
        }
        
    }
}
