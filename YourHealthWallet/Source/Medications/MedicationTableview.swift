//
//  MedicationTableview.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/23/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class MedicationTableview: TableView, UITableViewDelegate, UITableViewDataSource {
    
    var arrHeaderItem: [Dictionary<String, String>] = []
    var deletedMedicineIndex : IndexPath!
    
    var allSectionsData = [[AddMedicationInfo]]() {
        didSet {
            self.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeMedicationsDateCollectionView()
    }
    
    // MARK: - Initialization
    func initializeMedicationsDateCollectionView() {
        
        arrHeaderItem = [["Title": "Morning", "Icon": "Morning"],
                         ["Title": "Afternoon", "Icon": "Afternoon"],
                         ["Title": "Night", "Icon": "Night"]]
        
        //Register cell
        self.register(UINib(nibName: String(describing: MedicationListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MedicationListCell.self))
        
        //Register Header
        self.register(UINib(nibName: String(describing: DayHeaderCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DayHeaderCell.self))
        
        self.dataSource = self
        self.delegate = self
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MedicationListCell.self), for: indexPath) as! MedicationListCell
        cell.data = allSectionsData[indexPath.section][indexPath.row]
        cell.btnTick.addTarget(self, action: #selector(self.pressTickButton(_:)), for: .touchUpInside)
        cell.btnReminder.addTarget(self, action: #selector(self.pressReminderButton(_:)), for: .touchUpInside)
        cell.btnEdit.addTarget(self, action: #selector(self.pressEditButton(_:)), for: .touchUpInside)

        cell.selectionStyle = .none
        
        return cell
    }
    
    //The target function
    @objc func pressTickButton(_ sender: UIButton){
        print("\(sender)")
        guard let cell = sender.superview?.superview?.superview?.superview?.superview?.superview?.superview as? MedicationListCell else {
            return
        }
        
        let deleteIndexPath = self.indexPath(for: cell)
        deletedMedicineIndex = deleteIndexPath
        self.updateMedicine(objMedicine: allSectionsData[(deleteIndexPath?.section)!][(deleteIndexPath?.row)!])
    }
    
    @objc func pressEditButton(_ sender: UIButton){
        print("\(sender)")
        guard let cell = sender.superview?.superview?.superview?.superview as? MedicationListCell else {
            return
        }
        
        let editIndextpath = self.indexPath(for: cell)
        self.editMedicine(objMedicine: allSectionsData[(editIndextpath?.section)!][(editIndextpath?.row)!])
    }
    
    @objc func pressReminderButton(_ sender: UIButton){
        print("\(sender)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: String(describing: DayHeaderCell.self)) as! DayHeaderCell
        headerCell.labelTitle.text =  arrHeaderItem[section]["Title"]
        
        headerCell.imgHeader?.image = UIImage.init(named: arrHeaderItem[section]["Icon"]!)
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allSectionsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSectionsData[section].count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var section = 0
        for sectionData in allSectionsData {
            var row = 0
            for item in sectionData {
                if (section == indexPath.section) &&
                    (row == indexPath.row) {
                    item.selected = !item.selected!
                } else {
                    item.selected = false
                }
                row += 1
            }
            section += 1
        }

        UIView.transition(with: tableView,
                          duration: 0.50,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.reloadData()
        })
    
    }
    
    func updateMedicine(objMedicine:AddMedicationInfo){
        
        //Request parameters
        let param:Parameters = [AddMedicationRequestKey.kMedicationName:objMedicine.medicationname,
                                AddMedicationRequestKey.kMedicationstartdate:objMedicine.medicationstartdate,
                                AddMedicationRequestKey.kMedicationcategory:objMedicine.medicationcategory,
                                AddMedicationRequestKey.kMedicationtype:objMedicine.medicationtype,
                                AddMedicationRequestKey.kRemindertimes:objMedicine.remindertimes,
                                AddMedicationRequestKey.kDosage:objMedicine.dosage,
                                AddMedicationRequestKey.kDosageunit:objMedicine.dosageunit,
                                AddMedicationRequestKey.kDuration:objMedicine.duration,
                                AddMedicationRequestKey.kDaysfrequency:objMedicine.daysfrequency,
                                AddMedicationRequestKey.kMedium:objMedicine.medium,
                                AddMedicationRequestKey.kShape:objMedicine.shape,
                                AddMedicationRequestKey.kColor:objMedicine.color,
                                AddMedicationRequestKey.kInstructions:objMedicine.instructions,
                                AddMedicationRequestKey.kMedicationnotes:objMedicine.medicationnotes,
                                AddMedicationRequestKey.kMedicationnInd:true,
                                kUserId:AppUserDefaults.getUserID(),
                                "id":objMedicine.id];
        
        //API Call
        SVProgressHUD.show()
        MedicationsService.callWSForAddMedication(url: AdduserMedicinesUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .put, params: param, complitionHandler: {(Info, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            
            for (idx, objectToCompare) in self.allSectionsData.enumerated() {
                var array = objectToCompare
                let isDeleted = array.removeObject(object: objMedicine)
                if isDeleted{
                    self.allSectionsData[idx] = array
                    self.reloadData()
                }
            }
            
        })
    }
    
    func editMedicine(objMedicine:AddMedicationInfo){
     
        let editVC = MedicationAddEditVC()
        editVC.editMedicationObj = objMedicine
        editVC.isEditMedicine = true
        self.parentViewController()?.navigationController?.present(editVC, animated: true, completion: nil)
    }

}
