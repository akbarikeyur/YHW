//
//  WeightResultVC.swift
//  YourHealthWallet
//
//  Created by Vishal Nandoriya on 6/6/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class WeightResultVC: ViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet  var gaugeViewHead:WMGaugeView!
    @IBOutlet weak var imgCollectionView : UICollectionView!
    var arrMedia = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrMedia = ["weigh_sample","weigh_sample","weigh_sample"]
        
        self.imgCollectionView.register(UINib(nibName: String(describing:AddImageCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:AddImageCell.self))
        
        self.imgCollectionView.register(UINib(nibName: String(describing:WeightImageListCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing:WeightImageListCell.self))
        
        //Meter
        setMeter()
        
    }
    
    func setMeter()
    {
        DispatchQueue.main.async {
            
            self.gaugeViewHead.needleStyle = WMGaugeViewNeedleStyleFlatThin
            self.gaugeViewHead.maxValue = 270.0
            self.gaugeViewHead.scaleDivisions = 10
            self.gaugeViewHead.scaleStartAngle = 90
            self.gaugeViewHead.showRangeLabels = false
            self.gaugeViewHead.scaleEndAngle = 270
            self.gaugeViewHead.rangeValues = [90,180,270]
            self.gaugeViewHead.rangeColors = [WeightResultGraph1Color,WeightResultGraph2Color,WeightResultGraph3Color]
            self.gaugeViewHead.showUnitOfMeasurement = false
            self.gaugeViewHead.scaleDivisionsWidth = 0.008;
            self.gaugeViewHead.scaleSubdivisionsWidth = 0.010;
            self.gaugeViewHead.showUnitOfMeasurement = true
            self.gaugeViewHead.unitOfMeasurement = "Average"
            self.gaugeViewHead.unitOfMeasurementColor = FTAddActivityTitleColor
            self.gaugeViewHead.needleHeight = 0.2
            self.gaugeViewHead.needleScrewRadius = 0.02
            self.gaugeViewHead.needleWidth = 0.008
            self.gaugeViewHead.needleScrewStyle = WMGaugeViewNeedleScrewStylePlain
            self.gaugeViewHead.needleColor = UIColor.gray
            self.gaugeViewHead.needleScrewColor = UIColor.gray
            self.gaugeViewHead.showInnerRim = false
            self.gaugeViewHead.showInnerBackground = false
            self.gaugeViewHead.setValue(90, animated: true, duration: 0.5)
        }
    }
    
    @IBAction func didTapOnBackButton(_ sender: Button) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:WeightImageListCell.self), for: indexPath as IndexPath) as! WeightImageListCell
        
        cell.imgItem.image = UIImage.init(named: arrMedia[indexPath.row])
        return cell
    }
}
