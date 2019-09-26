//
//  TabStripViewController.swift
//  
//
//  Created by Shridhar on 6/20/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit
/*
protocol TabStripViewControllerDelegate : class {
    func didChangeTab(sender : TabStripViewController, fromViewController : UIViewController?, toViewController : UIViewController?)
    
    func canChangeTabThroughTabBar(sender : TabStripViewController, toViewController : UIViewController?) -> Bool
}

let buttonBarHeight : CGFloat = 56

class TabStripViewController: ButtonBarPagerTabStripViewController {

    weak var TabStripViewControllerDelegate : TabStripViewControllerDelegate?
    
    var buttonBarBackgroundColor = BlueColor {
        didSet {
            settings.style.buttonBarBackgroundColor = buttonBarBackgroundColor //Bar Background color
            settings.style.buttonBarItemBackgroundColor = buttonBarBackgroundColor //Bar color
            updateColors()
        }
    }
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = ClearColor
        containerView.backgroundColor = ClearColor
        
        settings.style.buttonBarBackgroundColor = buttonBarBackgroundColor //Bar Background color
        settings.style.buttonBarItemBackgroundColor = buttonBarBackgroundColor //Bar color
        settings.style.selectedBarBackgroundColor = UIColor.whiteColor()
        settings.style.buttonBarItemFont = UIFont(name: "HelveticaNeue-Light", size:14) ?? UIFont.systemFontOfSize(14)
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .blackColor()
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        
        settings.style.buttonBarLeftContentInset = 40
        settings.style.buttonBarRightContentInset = 40
        
        settings.style.buttonBarHeight = buttonBarHeight
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor(red: 138/255.0, green: 138/255.0, blue: 144/255.0, alpha: 1.0)
            newCell?.label.textColor = .whiteColor()
            newCell?.imageView.highlighted = true
            oldCell?.imageView.highlighted = false
            
            var oldVC : UIViewController?
            var newVC : UIViewController?
            
            if oldCell != nil {
                if let oldVCIndex = self.buttonBarView.indexPathForCell(oldCell!)?.item {
                    oldVC = self.viewControllers[oldVCIndex]
                }
            }
            
            if newCell != nil {
                if let newVCIndex = self.buttonBarView.indexPathForCell(newCell!)?.item {
                    newVC = self.viewControllers[newVCIndex]
                }
            }
            
            self.TabStripViewControllerDelegate?.didChangeTab(self, fromViewController: oldVC, toViewController: newVC)
        }
        
        super.viewDidLoad()
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let newVC = self.viewControllers[indexPath.item]
        
        let canChange = TabStripViewControllerDelegate?.canChangeTabThroughTabBar(self, toViewController: newVC)
        
        if canChange == nil || canChange! {
            super.collectionView(collectionView, didSelectItemAtIndexPath: indexPath)
        } else {
            let newCell = collectionView.cellForItemAtIndexPath(indexPath) as? ButtonBarViewCell
            newCell?.imageView.highlighted = false
            
            let oldCell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: currentIndex, inSection: 0)) as? ButtonBarViewCell
            oldCell?.imageView.highlighted = true
        }
    }
    
    func currentPage() -> Int {
        return pageForContentOffset(containerView.contentOffset.x)
    }
    
}
*/
