//
//  RemindersCollectionView.swift
//  YourHealthWallet
//
//  Created by Shridhar on 2/6/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class RemindersCollectionView: CollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var RemindersCollectionViewCellIdentifier = "RemindersCollectionViewCellIdentifier"
    
    var flowLayout: UICollectionViewFlowLayout!
    
    var currentCellIndex = 0
    
    var reminders: [AddReminderInfo] = [AddReminderInfo]()
    
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
    
    func initializeRemindersDateCollectionView() {
        //createDummyData()
        
        flowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .vertical
        
        flowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize
        flowLayout.estimatedItemSize = CGSize(width: 100, height: 100)
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 20.0
        flowLayout.minimumInteritemSpacing = 20.0
        
        self.register(UINib(nibName: "RemindersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RemindersCollectionViewCellIdentifier)
        
        self.dataSource = self
        self.delegate = self
    }
    /*
    func createDummyData() {
        reminders = [ReminderInfo]()
        
        var reminder = ReminderInfo()
        reminder.title = "1-Metoprolol, 2-Loratadine, Paracetemol"
        reminder.color = .Purpule
        reminder.time = "9:00 AM"
        reminder.image = #imageLiteral(resourceName: "pill_white")
        reminders.append(reminder)
        
        reminder = ReminderInfo()
        reminder.title = "Dr.John Doe Ortheopaedic Surgeon"
        reminder.color = .GreenLight
        reminder.time = "12:30 PM"
        reminder.image = #imageLiteral(resourceName: "stethoscope")
        reminders.append(reminder)
        
        reminder = ReminderInfo()
        reminder.title = "Check Blood Pressure"
        reminder.color = .Gold
        reminder.time = "02:30 PM"
        reminder.image = #imageLiteral(resourceName: "blood")
        reminders.append(reminder)
        
        reminder = ReminderInfo()
        reminder.title = "Buy 20 YHT before appointment."
        reminder.color = .Blue
        reminder.time = "05:30 PM"
        reminder.image = #imageLiteral(resourceName: "YHT")
        reminders.append(reminder)
    }
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reminders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RemindersCollectionViewCellIdentifier, for: indexPath) as! RemindersCollectionViewCell
        cell.data = reminders[indexPath.row]
        return cell
    }
}
