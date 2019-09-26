//
//  ViewController.swift
//  YourHealthWallet
//
//  Created by Shridhar on 1/30/18.
//  Copyright © 2018 yourhealthwallet. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var singleRow = true
    
    @IBAction func makeTwoRows(_ sender: UIBarButtonItem) {
        singleRow = !singleRow
        collectionView.reloadData()//.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let flowLayout = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TextCollectionViewCell
        if (indexPath.item % 2) == 0 {
//            cell.label.text = "asdasdasdasads asdasd asda";
            cell.label.text = "asdasd\n\n\nadsasdas\nasdas\(indexPath.item)";
            cell.backgroundColor = UIColor.red
        } else {
//            cell.label.text = "asdasdasdasads asdasd asdaasdasdasdasads asdasd asdaasdasdasdasads asdasd asdaasdasdasdasads asdasd asda";
            cell.label.text = "asdasd\n\n\nadsasdas\nasdas\(indexPath.item)";
            cell.backgroundColor = UIColor.green
        }
        
//        cell.widthConstraint.constant = (UIScreen.main.bounds.width * (singleRow ? 1 : 0.5)) - 20
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}

