//
//  MedicationReportsViewControllerCell.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/22/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
class MedicationReportsViewController: ViewController,UITableViewDelegate,UITableViewDataSource {

    let identifier:String = "MedicationReportTableViewCell"
    let sectionIdentifier:String = "MedicationReportTableViewSectionCell"
    
    @IBOutlet weak var tblView: TableView!
    
    init() {
        super.init(nibName: "MedicationReportsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tblView.register(UINib(nibName: sectionIdentifier, bundle: nil), forCellReuseIdentifier: sectionIdentifier)
    }

    
    //MARK:- Button Action
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOnProfilePicButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell :MedicationReportTableViewSectionCell = tableView.dequeueReusableCell(withIdentifier: sectionIdentifier) as! MedicationReportTableViewSectionCell
        cell.contentView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :MedicationReportTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! MedicationReportTableViewCell
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}
