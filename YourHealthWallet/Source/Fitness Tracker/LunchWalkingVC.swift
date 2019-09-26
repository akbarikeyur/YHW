//
//  LunchWalkingVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/27/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class LunchWalkingVC: ViewController {

    @IBOutlet weak var tblListView: TableView!

    var arrHeaderItem: [[String:Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //Register cell
        tblListView.register(UINib(nibName: String(describing: LunchWalkingCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LunchWalkingCell.self))
        
        arrHeaderItem = [["Icon": "calories1",
                          "Title": "Active Time",
                          "Value": "25min 58sec"],
                         
                         ["Icon": "calories1",
                          "Title": "Distance",
                          "Value": "3.9km"],
                         
                         ["Icon": "Lpace1",
                          "Title": "Average Pace",
                          "Value": "5.06/km"],
                         
                         ["Icon": "Lsteps1",
                          "Title": "Steps",
                          "Value": "8000"],
                         
                         ["Icon": "calories1",
                          "Title": "Calories",
                          "Value": "345"],
                         
                         ["Icon": "calories1",
                          "Title": "Average Heart Rate",
                          "Value": "156 bpm"],
                         
                         ["Icon": "calories1",
                          "Title": "Images",
                          "Value": "-"],
                         
                         ["Icon": "calories1",
                          "Title": "Notes",
                          "Value": "-"]
        ]
    }

    @IBAction func didTapOnBackButton(_ sender: Button) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension LunchWalkingVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHeaderItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let lunchWalkListCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LunchWalkingCell.self)) as! LunchWalkingCell
        
        lunchWalkListCell.imgList.image = UIImage.init(named:arrHeaderItem[indexPath.row]["Icon"] as! String)
        
        lunchWalkListCell.lblTitle.text = arrHeaderItem[indexPath.row]["Title"] as? String
        
        lunchWalkListCell.lblTime.text = arrHeaderItem[indexPath.row]["Value"] as? String
        
        return lunchWalkListCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
