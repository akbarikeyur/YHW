//
//  RemindersDateCollectionView.swift
//  YourHealthWallet
//
//  Created by Shridhar on 2/5/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class RemindersDateCollectionView: CollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var RemindersDateCollectionViewCellIdentifier = "RemindersDateCollectionViewCellIdentifier"
    private var flowLayout: UICollectionViewFlowLayout!
    
    private var currentCellIndex = 0
    private var numberOfDatesToShow = 20
    
    var reminderVC : ReminderViewController!
    
    public var startDate: Date! {
        didSet {
            currentCellIndex = 0
            setContentOffset(CGPoint.zero, animated: false)
            reloadData()
        }
    }
    public var didChangeDate : ((Date) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeRemindersDateCollectionView()
    }
    
    override var frame: CGRect {
        willSet {
            if newValue.equalTo(frame) == false {
                flowLayout?.invalidateLayout()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateLayout()
    }
    
    func updateLayout() {
        
        let cellWidth = self.bounds.width * 0.5
        flowLayout.itemSize = CGSize(width: cellWidth, height: self.bounds.height)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: cellWidth * 0.5, bottom: 0, right: cellWidth * 0.5)
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
    }
    
    func initializeRemindersDateCollectionView() {
        
//        self.isPagingEnabled = true
        self.dataSource = self
        self.delegate = self
        
        flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .horizontal
        
        self.register(UINib(nibName: "RemindersDateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RemindersDateCollectionViewCellIdentifier)
        
        updateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard startDate != nil else {
            return 0
        }
        return numberOfDatesToShow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RemindersDateCollectionViewCellIdentifier, for: indexPath) as! RemindersDateCollectionViewCell
        
        let newDate = getDateByAdding(date: startDate, index: indexPath.item)
        cell.setData(date: newDate)
        didChangeDate?(newDate)
        
        if currentCellIndex == indexPath.item {
            cell.contentView.alpha = 1
        } else {
            cell.contentView.alpha = 0.31
        }
        
        return cell
    }
    
    func getDateByAdding(date: Date, index: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = index
        
        if let newDate = Calendar.current.date(byAdding: dateComponents, to: date) {
            return newDate
        }
        
        return date
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollEnded()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if decelerate == false {
            scrollEnded()
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //To Set Properly for newly centered date.
        let newDate = getDateByAdding(date: startDate, index: currentCellIndex)
        didChangeDate?(newDate)
    }
    
    func scrollEnded() {
        let x = Int(contentOffset.x.rounded())
        
        let cellWidth = Int(flowLayout.itemSize.width.rounded())
        
        let reminder = x % cellWidth
        
        if reminder < (cellWidth/2) {
            currentCellIndex = x/cellWidth
        } else {
            currentCellIndex = x/cellWidth + 1
        }
        
        let newOffeset = CGPoint(x: CGFloat(currentCellIndex) * flowLayout.itemSize.width, y: 0)
        self.setContentOffset(newOffeset, animated: true)
        
        print("Current Index = \(currentCellIndex)")
        reloadData()
    }
}
