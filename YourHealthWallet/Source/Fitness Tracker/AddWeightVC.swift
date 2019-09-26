//
//  AddWeightVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/2/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class AddWeightVC: ViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblView: TableView!
    
    let identifiers:[String] = ["AddWeightDateCell", "AddWeightCell", "AddWeightBodyFatsCell","AddWeightImageCell", "AddWeightNoteCell"]
    
    init() {
        super.init(nibName: "AddWeightVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var param : [String : Any] = [String : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<identifiers.count{
            tblView.register(UINib(nibName: identifiers[i], bundle: nil), forCellReuseIdentifier: identifiers[i])
        }
    }
    
    //MARK:- Button Action
    @IBAction func didTapOnCloseButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
    
    //MARK:- Button Action
    @IBAction func didTapOnSaveButton(_ sender: Any) {
        self.view.endEditing(true)
        DispatchQueue.main.async {
            self.tblView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        
        if self.checkValidation() {
            //API Call
            
            let cell : AddWeightDateCell = tblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddWeightDateCell
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DATE_FORMAT.REMINDER_SERVER_DATE
            param[AddWeightKey.kWDate] = dateFormatter.string(from: cell._selectedDate)
            param[AddWeightKey.kWUserId] = AppUserDefaults.getUserID()
            param[AddWeightKey.kWNote] = "temp"
            print(param)
            AddWeightService.callWSForAddWeight(url: AddWeightUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken() , httpMethod: .post, params: param) { (data) in
                self.didTapOnCloseButton(self)
            }
        }

    }
    
    func checkValidation() -> Bool
    {
        
        //Weight validation
        let indexpathForWeight = IndexPath(row: 1, section: 0)
        if ((tblView.indexPathsForVisibleRows?.contains(indexpathForWeight))!) {
            
            let addWeightCell = tblView.cellForRow(at: indexpathForWeight) as! AddWeightCell
            
            if(addWeightCell.txtWeight.text?.isEmpty)!{
                AppDelegate.mainWindow().makeToast(kEnterAddWeight)
                return false
            }
            if addWeightCell.btnWeight.isSelected{
                param[AddWeightKey.kWWight] = addWeightCell.txtWeight.text! + " lbs"
                
            }
            else{
                param[AddWeightKey.kWWight] = addWeightCell.txtWeight.text! + " Kg"
            }
            
        }
        
        //Fate validation
        let indexpathForFate = IndexPath(row: 2, section: 0)
        if ((tblView.indexPathsForVisibleRows?.contains(indexpathForFate))!) {
            
            let addWeightBodyFatsCell = tblView.cellForRow(at: indexpathForFate) as! AddWeightBodyFatsCell
            
            if(addWeightBodyFatsCell.txtBodyFats.text?.isEmpty)!{
                AppDelegate.mainWindow().makeToast(kEnterBodyFate)
                return false
            }
            param[AddWeightKey.kWBodyFacts] = addWeightBodyFatsCell.txtBodyFats.text! + " %"
        }
        /*
        //Image validation
        let indexpathForImage = IndexPath(row: 3, section: 0)
        if ((tblView.indexPathsForVisibleRows?.contains(indexpathForImage))!) {
            
            let noteCell = tblView.cellForRow(at: indexpathForImage) as! AddWeightImageCell
            
            if !(noteCell.arrMedia.count > 0){
                AppDelegate.mainWindow().makeToast(kEnterWeightImage)
                return false
            }
        }
        */
        //Note validation
        let indexpathForNote = IndexPath(row: 4, section: 0)
        if ((tblView.indexPathsForVisibleRows?.contains(indexpathForNote))!) {
            
            let noteCell = tblView.cellForRow(at: indexpathForNote) as! AddWeightNoteCell
            
            if(noteCell.notesTxtView.text.isEmpty){
                AppDelegate.mainWindow().makeToast(kEnterAddWeightNote)
                return false
            }
            param[AddWeightKey.kWNote] = noteCell.notesTxtView.text
        }
        
        return true
    }
    
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return identifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row:Int = indexPath.row
        
        if(row == 0){
            let cell :AddWeightDateCell = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! AddWeightDateCell
            return cell
        }
        else if(row == 1){
            let cell :AddWeightCell = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! AddWeightCell
            return cell
        }
        else if(row == 2){
            let cell :AddWeightBodyFatsCell = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! AddWeightBodyFatsCell
            return cell
        }
        else if(row == 3){
            let cell :AddWeightImageCell = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! AddWeightImageCell
            return cell
        }
        else{
            let cell :AddWeightNoteCell = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! AddWeightNoteCell
            return cell
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

