//
//  MedicationMedicinesViewController.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/22/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class MedicationMedicinesViewController: ViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblView: TableView!
    
    let identifier:String = "MedicationMedicinesTableViewCell"
    let _medicines:[String] = ["Antivenin(Crotalidae) 50mg", "Vesanoid 10mg", "Gelucil 100mg", "CalMag Thins Tablet", "Vesograin 75 mg", "Vesanoid 10mg"];
    
    
    init() {
        super.init(nibName: "MedicationMedicinesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    
    //MARK:- Button Action
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnProfilePicButton(_ sender: Any) {
        
    }
    
    @IBAction func didTapOnAddMedicinesButton(_ sender: Any) {
        self.showPopup()
    }
    
    
    //MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _medicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :MedicationMedicinesTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! MedicationMedicinesTableViewCell
        cell.imgBtn.setImage(UIImage(named: "pill"+String(indexPath.row+1)), for: .normal)
        cell.titleLbl.text = _medicines[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:MedicationMedicinesTableViewCell  = tableView.cellForRow(at: indexPath) as! MedicationMedicinesTableViewCell
        cell.selectedBtn.isHidden = !cell.selectedBtn.isHidden
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MedicationMedicinesViewController: UIPopoverPresentationControllerDelegate, PopUpHideWithActionDelegate
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
        case 2:
            let addVC = MedicationAddDoseViewController()
            self.navigationController?.present(addVC, animated: true)
        default:
            break
        }
    }
}
