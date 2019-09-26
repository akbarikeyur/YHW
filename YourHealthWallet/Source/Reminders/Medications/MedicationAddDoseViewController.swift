//
//  MedicationAddDoseViewController.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/22/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class MedicationAddDoseViewController: ViewController,UITableViewDelegate,UITableViewDataSource, AddDoseSelectMedicationDelegate, MedicationSelectionDelegate {

    @IBOutlet weak var tblView: TableView!
    
    @IBOutlet var selectMedicationContView: View!
    @IBOutlet weak var selectMedicationTblView: TableView!
    
    let _medications:[String] = ["Antivenin(Crotalidae) 50mg", "Vesanoid 10mg", "Gelucil 100mg", "CalMag Thins Tablet", "Vesograin 75 mg", "Vesanoid 10mg"];
    var _selectedMedication:Int!
    
    let _quantity:[String] = ["2", "4", "6", "8", "10"]
    var _selectedQuantity:Int!
    
    let identifier:String = "MedicationMedicinesTableViewCell"
    
    let identifiers:[String] = ["AddDoseSelectMedicationTVC", "AddDoseSelectDateTimeTVC", "MedicationReminderTimesTVC" , "AddDoseDosageTVC", "MedicationSelectionTVC", "AddDoseAddNotesTVC"]
    
    init() {
        super.init(nibName: "MedicationAddDoseViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _selectedMedication = 0
        _selectedQuantity = -1
        
        for i in 0..<identifiers.count{
            tblView.register(UINib(nibName: identifiers[i], bundle: nil), forCellReuseIdentifier: identifiers[i])
        }
        selectMedicationTblView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    //MARK:- Button Action
    @IBAction func didTapOnCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tblView){
            return identifiers.count
        }
        else{
            return _medications.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row:Int = indexPath.row
        if(tableView == tblView){
            if(row == 0){
                let cell :AddDoseSelectMedicationTVC = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! AddDoseSelectMedicationTVC
                cell.delegate = self
                return cell
            }
            else if(row == 1){
                let cell :AddDoseSelectDateTimeTVC = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! AddDoseSelectDateTimeTVC
//                cell.update()
                return cell
            }
            else if(row == 2){
                let cell :MedicationReminderTimesTVC = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! MedicationReminderTimesTVC
//                cell.update()
                return cell
            }
            else if(row == 3){
                let cell :AddDoseDosageTVC = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! AddDoseDosageTVC
//                cell.update()
                return cell
            }
            else if(row == 4){
                let cell :MedicationSelectionTVC = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! MedicationSelectionTVC
                cell.delegate = self
                cell.titleLbl.text = "Quantity"
                cell.selectedLbl.text = _selectedQuantity == -1 ? "Select Quantity" : _quantity[_selectedQuantity]
                return cell
            }
            else{
                let cell :AddDoseAddNotesTVC = tableView.dequeueReusableCell(withIdentifier: identifiers[row]) as! AddDoseAddNotesTVC
                return cell
            }
        }
        else{
            let cell :MedicationMedicinesTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! MedicationMedicinesTableViewCell
            cell.imgBtn.setImage(UIImage(named: "pill"+String(indexPath.row+1)), for: .normal)
            cell.titleLbl.text = _medications[indexPath.row]
            if(_selectedMedication == indexPath.row){
                cell.selectedBtn.isHidden = false
            }
            else{
                cell.selectedBtn.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == selectMedicationTblView){
            let selectedCell:MedicationMedicinesTableViewCell  = tableView.cellForRow(at: indexPath) as! MedicationMedicinesTableViewCell
            selectedCell.selectedBtn.isHidden = false
            let cell:AddDoseSelectMedicationTVC  = tblView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddDoseSelectMedicationTVC
            cell.imgBtn.setImage(selectedCell.imgBtn.image(for: .normal), for: .normal)
            cell.titleLbl.text = selectedCell.titleLbl.text
            _selectedMedication =  indexPath.row
            DPPickerManager.shared.pickerClose(self)
        }
    }
    
    //MARK:- AddDoseSelectMedicationDelegate
    func openSelectMedicationPopup() {
        self.selectMedicationTblView.reloadData()
        DPPickerManager.shared.showPicker(title: "Select Medication", view: selectMedicationContView) { (isCancel) in
        }
    }
    
    //MARK:- MedicationSelectionDelegate
    func openSelectionPopup() {
        DPPickerManager.shared.showPicker(title: "Select Quantity", selected: _selectedQuantity == -1 ? _quantity[0] : _quantity[_selectedQuantity], strings:_quantity) { (value, index, isCancel) in
            if !isCancel {
                self._selectedQuantity = index
                let cell:MedicationSelectionTVC  = self.tblView.cellForRow(at: IndexPath(row: 4, section: 0)) as! MedicationSelectionTVC
                cell.selectedLbl.text = self._quantity[self._selectedQuantity]
            }
        }
    }
}
