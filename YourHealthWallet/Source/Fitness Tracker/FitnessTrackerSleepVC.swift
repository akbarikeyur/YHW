//
//  FitnessTrackerSleepVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/20/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import HealthKit

class FitnessTrackerSleepVC: ViewController, SleepManualShowHideDelegate {
    
    @IBOutlet weak var tblListView: TableView!
    var isAddManual : Bool?
    
    var workouts: [HKSample]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isAddManual = true
        
        //Register cell
        tblListView.register(UINib(nibName: String(describing: SleepFirstCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SleepFirstCell.self))
        
        tblListView.register(UINib(nibName: String(describing: SleepTimeCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SleepTimeCell.self))
        
        tblListView.register(UINib(nibName: String(describing: SleepAddManualCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SleepAddManualCell.self))
        
        self.getSleepDayType(selectedDaysType: 0)

    }
    
    //Delegate day
    func getSleepDayType(selectedDaysType: Int) {
        if selectedDaysType == 1{
            HealthManagerKit.Shared.retrieveSleepAnalysis { (result, error) in
                let filterItems = result?.filter{item in return item.startDate.compare(.isToday)}
                self.workouts = filterItems
                self.tblListView.reloadData()
            }
        }else{
            
            HealthManagerKit.Shared.retrieveSleepAnalysis { (result, error) in
                let filterItems = result?.filter{item in return item.startDate.compare(.isToday)}
                self.workouts = filterItems
                self.tblListView.reloadData()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }

    func showHide(isHide: Bool, reloadIndex: IndexPath) {
        isAddManual = isHide
        if isAddManual! {
            let indexSet = IndexSet(arrayLiteral: 2)
            tblListView.insertSections(indexSet, with: .fade)
        }
        else
        {
            let indexSet = IndexSet(arrayLiteral: 2)
            tblListView.deleteSections(indexSet, with: .fade)
        }
    }
    
    @objc func addManualSleepTime(){
        let addActivityVC = AddSleepVC()
        self.present(addActivityVC, animated: true, completion: nil)
    }
}

extension FitnessTrackerSleepVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return isAddManual! ? 3 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cycleFirstCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SleepFirstCell.self)) as! SleepFirstCell
            cycleFirstCell.delegate = self
            cycleFirstCell.setCalculateSleepData(firstCellWorkouts: self.workouts)

            return cycleFirstCell
        case 1:
            let cycleListCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SleepTimeCell.self)) as! SleepTimeCell
            cycleListCell.setCalculateSleepData(firstCellWorkouts: self.workouts)
            return cycleListCell
        case 2:
            let cycleFirstCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SleepAddManualCell.self)) as! SleepAddManualCell
            
            cycleFirstCell.btnAdd.addTarget(self, action:#selector(addManualSleepTime), for: .touchUpInside)

            return cycleFirstCell
        default:
           return TableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

