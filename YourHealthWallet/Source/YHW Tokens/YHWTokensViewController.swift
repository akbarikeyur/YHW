//
//  YHWTokensViewController.swift
//  YourHealthWallet
//
//  Created by Amisha on 2/12/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class YHWTokensViewController: ViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var yearBtn: Button!
    @IBOutlet weak var yhtLbl: Label!
    @IBOutlet weak var tblView: TableView!
    
    @IBOutlet weak var activityLineView: View!
    
    @IBOutlet weak var buyLineView: View!
    @IBOutlet weak var sendLineView: View!
    
    init() {
        super.init(nibName: "YHWTokensViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
    
    func setupUI(){
        
        tblView.tableFooterView = UIView()
        tblView.register(UINib(nibName: "YHWTokensTVC", bundle: nil), forCellReuseIdentifier: "YHWTokensTVC")
        tblView.separatorStyle = .none
        
        let str:String = yhtLbl.text!
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: str)
        var font1:UIFont = yhtLbl.font
        font1 = font1.withSize(46)
        var font2:UIFont = yhtLbl.font
        font2 = font2.withSize(22)
        attributedString.addAttribute(NSAttributedStringKey.font, value: font1, range: NSMakeRange(0, str.length()))
        if let range = str.range(of: " YHT") {
            let startPos = str.distance(from: str.startIndex, to: range.lowerBound)
            let endPos = str.distance(from: str.startIndex, to: range.upperBound)
            let wordToEndRange = NSRange(location: startPos, length: 4)
            attributedString.addAttribute(NSAttributedStringKey.font,
                                          value: font2, range: wordToEndRange)
        }
        yhtLbl.attributedText = attributedString
        
    }
    
    
    //MARK:- UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :YHWTokensTVC = tableView.dequeueReusableCell(withIdentifier: "YHWTokensTVC") as! YHWTokensTVC
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}


