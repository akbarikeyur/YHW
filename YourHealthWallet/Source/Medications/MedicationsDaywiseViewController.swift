//
//  MedicationsDaywiseViewController.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/22/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import SVProgressHUD

class MedicationsDaywiseViewController: ViewController {
    
    @IBOutlet weak var buttonMonthYear: Button!
    @IBOutlet weak var dateCollectionView: MedicationDateCollectionView!
    @IBOutlet weak var medicationTableView: MedicationTableview!
    
    var medicationsMorning: [AddMedicationInfo]!
    var medicationsAfternoon: [AddMedicationInfo]!
    var medicationsNight: [AddMedicationInfo]!
    var serverMedicines: [AddMedicationInfo]!
    
    var selectedDate: Date! {
        didSet {
            let formater = DateFormatter()
            formater.dateFormat = "MMMM yyyy"
            let monthAndYear = formater.string(from: selectedDate)
            self.buttonMonthYear.setTitle(monthAndYear, for: .normal)
        }
    }
    
    init() {
        super.init(nibName: "MedicationsDaywiseViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedDate = Date()
        dateCollectionView.startDate = selectedDate
        dateCollectionView.didChangeDate = { (newDate) in
            self.selectedDate = newDate
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.callGetMedicines()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated:
            true)
    }
    
    @IBAction func didTapOnMonthYearButton(_ sender: Button) {
        
        let min = Date()
        let max = min.addingTimeInterval(31536000) // 1 year
        DPPickerManager.shared.showPicker(title: "Date Picker", selected: selectedDate, min: min, max: max) { (date, cancel) in
            if !cancel {
                self.selectedDate = date
                self.dateCollectionView.startDate = self.selectedDate
            }
        }
    }
    
    @IBAction func didTapOnAdd(_ sender: Button) {
        
        self.showPopup()
    }
    
    func callGetMedicines(){
        
        SVProgressHUD.show()
        MedicationsService.callWSForGetMedication(url: GetuserMedicinesUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .get, complitionHandler: { (medicationLists, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            
            guard medicationLists != nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            
            self.serverMedicines = medicationLists?.results?.filter { $0.medtaken_ind == false }

            if self.serverMedicines.count > 0 {
                
                self.medicationsMorning = [AddMedicationInfo]()
                self.medicationsAfternoon = [AddMedicationInfo]()
                self.medicationsNight = [AddMedicationInfo]()
                
                for objMedicine in self.serverMedicines {
                    let hour = Calendar.current.component(.hour, from: Date(fromString: objMedicine.medicationstartdate, format: .isoDateTimeMilliSec)!)

                    objMedicine.selected = false
                    
                    switch hour {
                    case 6..<12 :
                        print(NSLocalizedString("Morning", comment: "Morning"))
                        
                        self.medicationsMorning.append(objMedicine)
                    case 12..<17 :
                        print(NSLocalizedString("Afternoon", comment: "Afternoon"))
                        self.medicationsAfternoon.append(objMedicine)
                    case 17..<22 :
                        print(NSLocalizedString("Evening", comment: "Evening"))
                        self.medicationsNight.append(objMedicine)
                    default:
                        print(NSLocalizedString("Night", comment: "Night"))
                        self.medicationsNight.append(objMedicine)
                    }
                }
                let arrayMorning = self.medicationsMorning.sorted(by: { $0.medicationstartdate < $1.medicationstartdate})
                
                let arrayAfternoon = self.medicationsAfternoon.sorted(by: { $0.medicationstartdate < $1.medicationstartdate})
                
                let arrayNight = self.medicationsNight.sorted(by: { $0.medicationstartdate < $1.medicationstartdate})
                
                self.medicationTableView.allSectionsData.removeAll()
                
                self.medicationTableView.allSectionsData.append(arrayMorning)
                self.medicationTableView.allSectionsData.append(arrayAfternoon)
                self.medicationTableView.allSectionsData.append(arrayNight)
            }
        })
        
    }
}
extension MedicationsDaywiseViewController: UIPopoverPresentationControllerDelegate, PopUpHideWithActionDelegate
{
    func showPopup()
    {
        let (popUpVC, pVC) = getPopOverViewController()
        popUpVC.delegate = self
        pVC?.delegate = self
        self.navigationController?.present(popUpVC, animated: true, completion: nil)
    }
    
    func hideWithIndex(index: NSInteger) {
        
        switch index {
        case 0:
            let addVC = MedicationAddEditVC()
            self.navigationController?.present(addVC, animated: true)
        case 1:
            break
//        case 2:
//            let addVC = MedicationHistoryVC()
//            self.navigationController?.present(addVC, animated: true)
        default:
            break
        }
    }
}

/*
 This method is used by MedicationsDaywiseViewController and MedicationMedicinesViewController
 */
func getPopOverViewController() -> (PopOverViewController, UIPopoverPresentationController?) {
    let arrHeaderItem = [["Title": "Add Medication", "Icon": "add-medication"],
                         ["Title": "Take Snapshot", "Icon": "take-snapshot"]
                         ]
//    ["Title": "Medication History", "Icon": "add-dose"]
    let popUpVC = PopOverViewController(arrItems: arrHeaderItem)
    
    popUpVC.modalPresentationStyle = .overCurrentContext
    popUpVC.modalTransitionStyle = .crossDissolve
    popUpVC.preferredContentSize = CGSize.init(width: 200, height: 100)
    let pVC = popUpVC.popoverPresentationController
    pVC?.permittedArrowDirections = .any
    
    pVC?.sourceView = UIView()
    pVC?.sourceRect = CGRect.init(x: 100, y: 100, width: 1, height: 1)
    pVC?.backgroundColor = UIColor.black
    return (popUpVC, pVC)
}
