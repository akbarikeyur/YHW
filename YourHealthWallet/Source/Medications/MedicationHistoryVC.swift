//
//  MedicationHistoryVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 8/9/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit
import SVProgressHUD

class MedicationHistoryVC: UIViewController, UITableViewDataSource, UITableViewDelegate, FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var tableView: TableView!
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet var titleButton: UIButton?
    var isTapped = false

    var gregorian: Calendar?
    var minimumDate: Date?
    var maximumDate: Date?
    var EventsData = [AddMedicationInfo]()
    var selectedData = [AddMedicationInfo]()
    let identifier:String = "MedicationHistoryCell"

   
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    func do_refresh()
    {
        DispatchQueue.main.async(execute: {
            
            self.calendar.reloadData()
            
            return
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.appearance.weekdayTextColor = ColorType.Voilet.value
        calendar.appearance.headerTitleColor = ColorType.Voilet.value
        calendar.appearance.selectionColor = ColorType.Voilet.value
        calendar.appearance.todayColor = ColorType.Voilet.value
        calendar.appearance.todaySelectionColor = UIColor.black
        
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)

        self.callGetMedicines()
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }
        
        self.calendar.select(Date())
        self.calendar.clipsToBounds = true
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calendar.scope = .week
        
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        setupNavigationTitle()
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("\(#function)")
    }
    
    func setupNavigationTitle() {
        //Set Navigation Title with button view
        titleButton?.addTarget(self, action: #selector(self.titleButtonTapped), for: .touchUpInside)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-yy"
        titleButton?.setTitle(dateFormatter.string(from: Date()), for: .normal)
    }
    
    @objc func titleButtonTapped() {
        isTapped = !isTapped
        var selectedScope = FSCalendarScope.month
        if !isTapped {
            selectedScope = FSCalendarScope.week
        }
        calendar.setScope(selectedScope, animated: true)
    }
    
    // MARK:- UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let presentdate = formatter.string(from: date)
        selectedData.removeAll()
        
        for d in EventsData{
            
            let date = d.medicationstartdate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DATE_FORMAT.MEDICATION_SERVER_DATE
            let dateFromString : NSDate = dateFormatter.date(from: date!)! as NSDate
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let datenew = dateFormatter.string(from: dateFromString as Date)
            if(presentdate == datenew)
            {
                selectedData.append(d)
            }
        }
        tableView.reloadData()
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-yy"
        titleButton?.setTitle(dateFormatter.string(from: calendar.currentPage), for: .normal)
        
    }
    
    // MARK:- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! MedicationHistoryCell
        //cell.imgBtn.setImage(UIImage(named: "pill"+String(indexPath.row+1)), for: .normal)
        cell.titleLbl.text = selectedData[indexPath.row].medicationname
        cell.descLbl.text = selectedData[indexPath.row].dosageunit
        let dateTimeString = Date(fromString: selectedData[indexPath.row].medicationstartdate, format: .isoDateTimeMilliSec)?.toString(format: .custom(DATE_FORMAT.MEDICATION_TIME))
        cell.timeLbl.text = dateTimeString!
        return cell
    }
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK:- Target actions
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let dateString = self.dateFormatter2.string(from: date)
        
        for d in EventsData{
            
            let date = d.medicationstartdate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DATE_FORMAT.MEDICATION_SERVER_DATE
            let dateFromString : NSDate = dateFormatter.date(from: date!)! as NSDate
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let datenew = dateFormatter.string(from: dateFromString as Date)
            
            if datenew.contains(dateString) {
                return 1
            }
        }
        return 0
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor? {
        let dateString = self.dateFormatter2.string(from: date)
        for d in EventsData{
            let date = d.medicationstartdate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DATE_FORMAT.MEDICATION_SERVER_DATE
            let dateFromString : NSDate = dateFormatter.date(from: date!)! as NSDate
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let datenew = dateFormatter.string(from: dateFromString as Date)
            if datenew.contains(dateString) {
                return ColorType.Voilet.value
            }
        }
        return nil
    }
    
    func callGetMedicines(){
        
        SVProgressHUD.show()
        MedicationsService.callWSForGetMedication(url: GetuserMedicinesUrl + "?access_token=" + AppUserDefaults.getUserAuthtoken(), httpMethod: .get, complitionHandler: { (medicationLists, error) in
            
            SVProgressHUD.dismiss()
            guard error == nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            
            guard medicationLists != nil else{
                AppDelegate.mainWindow().makeToast(kSomethingWentWrong)
                return
            }
            self.EventsData = (medicationLists?.results)!
            if self.EventsData.count > 0 {

                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                
                let presentdate = formatter.string(from: Date())
                
                for d in self.EventsData{
                    
                    let date = d.medicationstartdate
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = DATE_FORMAT.MEDICATION_SERVER_DATE
                    let dateFromString : NSDate = dateFormatter.date(from: date!)! as NSDate
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let datenew = dateFormatter.string(from: dateFromString as Date)
                    if(presentdate == datenew)
                    {
                        self.selectedData.append(d)
                    }
                    
                }
                self.tableView.reloadData()
                self.do_refresh()
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
