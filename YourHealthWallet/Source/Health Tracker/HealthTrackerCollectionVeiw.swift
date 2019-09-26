//
//  HealthTrackerCollectionVeiw.swift
//  YourHealthWallet
//
//  Created by Shridhar on 21/02/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class HealthTrackerCollectionVeiw: CollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let HTHeartRateCollectionViewCellIdentifier = "HTHeartRateCollectionViewCellIdentifier"
    private let HTBloodSugarCellIdentifier = "HTBloodSugarCellIdentifier"
    private let HTBodyWeightCellIdentifier = "HTBodyWeightCellIdentifier"
    
    private var flowLayout: UICollectionViewFlowLayout!
    
    private var currentCellIndex = 0 {
        didSet {
            let type = HealthTrackerType(rawValue: currentCellIndex) ?? .HeartRate
            didChangeHealtTrackerType?(type)
        }
    }
    
    public var didChangeHealtTrackerType : ((HealthTrackerType) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeHealthTrackerCollectionView()
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
        
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 24, bottom: 1, right: 24)
        flowLayout.minimumLineSpacing = 14
        flowLayout.minimumInteritemSpacing = 0.0
        
        let cellWidth = self.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right
        flowLayout.itemSize = CGSize(width: cellWidth, height: self.bounds.height - 2)
    }
    
    func initializeHealthTrackerCollectionView() {
        
        currentCellIndex = HealthTrackerType.HeartRate.rawValue
        
        self.dataSource = self
        self.delegate = self
        
        flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .horizontal
        
        self.register(UINib(nibName: "HTHeartRateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HTHeartRateCollectionViewCellIdentifier)
        self.register(UINib(nibName: "HTBloodSugarCell", bundle: nil), forCellWithReuseIdentifier: HTBloodSugarCellIdentifier)
        self.register(UINib(nibName: "HTBodyWeightCell", bundle: nil), forCellWithReuseIdentifier: HTBodyWeightCellIdentifier)
        
        updateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        
        if indexPath.item == 0 {
            let heartRateCell = collectionView.dequeueReusableCell(withReuseIdentifier: HTHeartRateCollectionViewCellIdentifier, for: indexPath) as! HTHeartRateCollectionViewCell
            heartRateCell.labelBPSValue.text = "\(indexPath.item)\(indexPath.item)\(indexPath.item)"
            cell = heartRateCell
        } else if indexPath.item == 1 {
            let bloodSugarCell = collectionView.dequeueReusableCell(withReuseIdentifier: HTBloodSugarCellIdentifier, for: indexPath) as! HTBloodSugarCell
            cell = bloodSugarCell
        } else {
            let bodyWeightCell = collectionView.dequeueReusableCell(withReuseIdentifier: HTBodyWeightCellIdentifier, for: indexPath) as! HTBodyWeightCell
            cell = bodyWeightCell
        }
        return cell
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
    }
    
    func scrollEnded() {
        let x = contentOffset.x
        
        let paginationValue = flowLayout.itemSize.width + flowLayout.minimumLineSpacing
        
        let reminder = x.truncatingRemainder(dividingBy: paginationValue)
        
        if reminder < (paginationValue/2.0) {
            currentCellIndex = Int(x/paginationValue)
        } else {
            currentCellIndex = Int(x/paginationValue + 1)
        }
        
        let newOffeset = CGPoint(x: CGFloat(currentCellIndex) * paginationValue, y: 0)
        self.setContentOffset(newOffeset, animated: true)
        
        print("Current Index = \(currentCellIndex)")
        reloadData()
        
    }
    
}
