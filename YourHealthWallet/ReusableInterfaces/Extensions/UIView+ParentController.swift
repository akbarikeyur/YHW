//
//  UIView+RUI.swift
//  Juicer
//
//  Created by SrikanthKV on 3/16/15.
//  Copyright (c) 2015 Digital Juice. All rights reserved.
//

import UIKit

public extension UIView {
    public func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                
                var parsedViewController : UIViewController = parentResponder as! UIViewController
                while parsedViewController.parent != nil {
                    parsedViewController = parsedViewController.parent!
                }
                
                return parentResponder as! UIViewController!
            }
        }
        return nil
    }
}
