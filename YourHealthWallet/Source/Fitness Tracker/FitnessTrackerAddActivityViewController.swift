//
//  FitnessTrackerAddActivityViewController.swift
//  YourHealthWallet
//
//  Created by Amisha on 3/14/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class FitnessTrackerAddActivityViewController: ViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblView: TableView!
    
    let identifiers:[String] = ["FitnessTrackerAddActivityDateDescTVC", "FitnessTrackerAddActivityTimeTVC", "WakeUpTimeCell" , "FitnessTrackerAddActivityNotesTVC"]
    
    init() {
        super.init(nibName: "FitnessTrackerAddActivityViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<identifiers.count{
            tblView.register(UINib(nibName: identifiers[i], bundle: nil), forCellReuseIdentifier: identifiers[i])
        }
    }
    
    //MARK:- Button Action
    @IBAction func didTapOnCloseButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func indexPathForView(_ view: UIView) -> IndexPath? {
        let center = view.center
        let viewCenter = tblView.convert(center, from: view.superview)
        let indexPath = tblView.indexPathForRow(at: viewCenter)
        return indexPath
    }
    
    //MARK:- Button Action
    @IBAction func didTapOnSaveButton(_ sender: Any) {
        
        if self.checkValidation(){
            //API Call
        }
    }
    
    func checkValidation()-> Bool
    {
        //Date & Description validation
        let indexpathForDate = IndexPath(row: 0, section: 0)
        if ((tblView.indexPathsForVisibleRows?.contains(indexpathForDate))!) {
            
            let dateCell = tblView.cellForRow(at: indexpathForDate) as! FitnessTrackerAddActivityDateDescTVC
            
            if(dateCell.descTxtView.text.isEmpty){
                AppDelegate.mainWindow().makeToast(kEnterAddActivityDescription)
                return false
            }
        }
        
        //Sleep validation
        let indexpathForSleep = IndexPath(row: 1, section: 0)
        if ((tblView.indexPathsForVisibleRows?.contains(indexpathForSleep))!) {
            
            let sleepCell = tblView.cellForRow(at: indexpathForSleep) as! FitnessTrackerAddActivityTimeTVC
            
            if(sleepCell.hrText.text?.isEmpty)!{
                AppDelegate.mainWindow().makeToast(kEnterAddActivitySleepingTime)
                return false
            }
        }
        
        //Wakeup validation
        let indexpathForWakup = IndexPath(row: 2, section: 0)
        if ((tblView.indexPathsForVisibleRows?.contains(indexpathForWakup))!) {
            
            let wakeUpCell = tblView.cellForRow(at: indexpathForWakup) as! WakeUpTimeCell
            
            if(wakeUpCell.hrText.text?.isEmpty)!{
                AppDelegate.mainWindow().makeToast(kEnterAddActivityWakeupTime)
                return false
            }
        }
        
        //Note validation
        let indexpathForNote = IndexPath(row: 3, section: 0)
        if ((tblView.indexPathsForVisibleRows?.contains(indexpathForNote))!) {
            
            let noteCell = tblView.cellForRow(at: indexpathForNote) as! FitnessTrackerAddActivityNotesTVC
            
            if(noteCell.notesTxtView.text.isEmpty){
                AppDelegate.mainWindow().makeToast(kEnterAddActivityNote)
                return false
            }
        }
        return true
    }
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return identifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row:Int = indexPath.row
        
        switch indexPath.row {
        case 0:
            let cell :FitnessTrackerAddActivityDateDescTVC = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! FitnessTrackerAddActivityDateDescTVC
            return cell
        case 1:
            let cell :FitnessTrackerAddActivityTimeTVC = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! FitnessTrackerAddActivityTimeTVC
            cell.headerLbl.text = "Sleeping Time"
            return cell
            
        case 2:
            let cell :WakeUpTimeCell = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! WakeUpTimeCell
            cell.headerLbl.text = "Wake Up  Time"
            return cell
            
        case 3:
            let cell :FitnessTrackerAddActivityNotesTVC = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! FitnessTrackerAddActivityNotesTVC
            return cell
            
        default:
            return TableViewCell()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
