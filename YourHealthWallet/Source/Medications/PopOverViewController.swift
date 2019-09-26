//
//  PopOverViewController.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 2/26/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

protocol PopUpHideWithActionDelegate: class
{
    func hideWithIndex(index:NSInteger)
}

class PopOverViewController: ViewController
{
    @IBOutlet weak var itemsTableView: TableView!
    
    // MARK:- Delegate
    weak var delegate: PopUpHideWithActionDelegate?
    
    var arrHeaderItem: [Dictionary<String, String>] = []
    @IBOutlet var tableViewHeightConstraint:NSLayoutConstraint!
    init(arrItems:[Dictionary<String, String>]) {
        super.init(nibName: "PopOverViewController", bundle: nil)
        self.arrHeaderItem = arrItems

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHeightConstraint.constant = itemsTableView.contentSize.height
        self.loadViewIfNeeded()
        //Register cell
        itemsTableView.register(UINib(nibName: String(describing: PopUpItemCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PopUpItemCell.self))
        
    }
    
    @IBAction func didTapOnHide(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PopOverViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PopUpItemCell.self), for: indexPath) as! PopUpItemCell
        cell.imgItem.image = UIImage.init(named: arrHeaderItem[indexPath.row]["Icon"]!)
        cell.labelTitle.text =  arrHeaderItem[indexPath.row]["Title"]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrHeaderItem.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dismiss(animated: true) {
            self.delegate?.hideWithIndex(index: indexPath.row)
        }
        
    }
}
