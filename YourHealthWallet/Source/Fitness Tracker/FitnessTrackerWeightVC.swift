//
//  FitnessTrackerWeightVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 5/01/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class FitnessTrackerWeightVC: ViewController {
    
    @IBOutlet weak var tblListView: TableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register cell
        tblListView.register(UINib(nibName: String(describing: WeightListCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeightListCell.self))
        
        tblListView.register(UINib(nibName: String(describing: WeightFirstCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WeightFirstCell.self))
    }
    
    @IBAction func didTapOnAdd(_ sender: Button) {
        
        //self.showPopup()
        let addWeightVC = AddWeightVC()
        self.navigationController?.pushViewController(addWeightVC, animated: false)
        //self.present(addWeightVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FitnessTrackerWeightVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (section == 0) ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let walkFirstCell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeightFirstCell.self)) as! WeightFirstCell
            
            return walkFirstCell
        }
        else{
            let walkListCell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeightListCell.self)) as! WeightListCell
            
            return walkListCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addWeightVC = WeightResultVC()
        self.navigationController?.pushViewController(addWeightVC, animated: true)
    }
    
}
