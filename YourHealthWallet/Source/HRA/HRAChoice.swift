//
//  HRAChoice.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 3/5/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class HRAChoice: UIView,UITableViewDelegate,UITableViewDataSource {
    
    private let tableView = UITableView()
    
    private var lastIndexPath: IndexPath?

    var delegate: HRAChoiceDelegate? = nil
    
    var separatorStyle: UITableViewCellSeparatorStyle = .singleLine
    
    var font = UIFont(name: "Roboto-Regular", size: 16)
    
    var selectionType: SelectionType = .single
    
    var data: [Selectable] = [] {
        didSet {
            if let index = data.index(where: { $0.isSelected } ) {
                lastIndexPath = IndexPath(item: index, section: 0)
            }
            tableView.reloadData()
        }
    }
    
    @IBInspectable var cellHeight: CGFloat = 60
    @IBInspectable var selectedImage: UIImage?
    @IBInspectable var unselectedImage: UIImage?
    @IBInspectable var isRightToLeft: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = true
        tableView.indicatorStyle = .black
        self.addSubview(tableView)
        tableView.frame = rect
        let backgroundView = UIView(); backgroundView.backgroundColor = UIColor.white
        tableView.backgroundView = backgroundView
        #if TARGET_INTERFACE_BUILDER
            self.data = [Item(title: "Item 1", isSelected: false, isUserSelectEnable: true),
                         Item(title: "Item 2", isSelected: true, isUserSelectEnable: true),
                         Item(title: "Item 3", isSelected: false, isUserSelectEnable: true)]
        #endif
        
    }
    
    
    // MARK: TableView Delegate and datasource
    final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    final func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = RadioCell()
        
        let item = data[indexPath.row]
        
        cell.imgRadio.image = item.isSelected ? selectedImage : unselectedImage
        
        cell.selectionStyle = .none
        cell.lblTitle.text = item.title
        cell.lblTitle.font = font ?? cell.lblTitle.font
        
        cell.isRightToLeft = isRightToLeft
        
        return cell
    }
    
    final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return cellHeight
    }
    
    final func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        guard data[indexPath.row].isUserSelectEnable == true else{
            return
        }
        
        
        if selectionType == .single {
            for i in 0..<data.count {
                data[i].isSelected = false
            }
            data[indexPath.row].isSelected = true
        }else{
            let item = data[indexPath.row]
            item.isSelected = !item.isSelected
        }
        
        if let lastIndexPath = lastIndexPath {
            tableView.reloadRows(at: [lastIndexPath], with: .automatic)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        lastIndexPath = indexPath
        delegate?.didSelectRowAt(indexPath: indexPath)

    }
    
    // MARK: Get selected item functions
    

    func getSelectedItems() -> [Selectable] {
        
        let selectedItem = data.filter { (item) -> Bool in
            return item.isSelected == true
        }
        
        return selectedItem
    }
    

    func getSelectedItemsJoined(separator: String = ",") -> String {
        
        let selectedItem = data.filter { (item) -> Bool in
            return item.isSelected == true
            }.map{String($0.title)}.joined(separator: separator)
        
        return selectedItem
    }
    
    
}

@objc protocol HRAChoiceDelegate: class {
    func didSelectRowAt(indexPath: IndexPath)
}

@objc protocol Selectable {
    var isSelected: Bool{ get set }
    var title: String{ get set }
    var isUserSelectEnable: Bool{ get set }
    
}

class Item: NSObject,Selectable {
    
    var title: String
    var isSelected: Bool = false
    var isUserSelectEnable: Bool = true
    
    init(title: String, isSelected: Bool, isUserSelectEnable: Bool) {
        self.title = title
        self.isSelected = isSelected
        self.isUserSelectEnable = isUserSelectEnable
    }
    
}


extension Sequence where Iterator.Element == Selectable {
    func getSelectedItemsJoined(separator: String) -> String {
        
        let selectedItem = self.filter { (item) -> Bool in
            return item.isSelected == true
            }.map{String($0.title)}.joined(separator: separator)
        
        return selectedItem
    }
}

// single and multiple
@objc enum SelectionType: NSInteger{
    case single
    case multiple
}

class RadioCell: UITableViewCell{
    var lblTitle: UILabel = UILabel()
    var imgRadio: UIImageView = UIImageView()
    
    var isRightToLeft: Bool!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if isRightToLeft == true {
            imgRadio.frame = CGRect(x: rect.width - 30, y: 20, width: 20, height: 20)
            lblTitle.frame = CGRect(x: 5, y: 20, width: rect.width - 35, height: 20)
            lblTitle.textAlignment = .right
        }else{
            imgRadio.frame = CGRect(x: 25, y: 20, width: 20, height: 20)
            lblTitle.frame = CGRect(x: 60, y: 20, width: rect.width - 10, height: 20)
            lblTitle.textAlignment = .left
        }
        
        addSubview(imgRadio)
        addSubview(lblTitle)
    }
    
}
