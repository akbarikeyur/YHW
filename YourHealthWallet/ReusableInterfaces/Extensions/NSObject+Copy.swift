//
//  CopyingValues.swift
//  
//
//  Created by Shridhar on 6/23/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

extension NSObject {
    func copyValues(fromObject : AnyObject?) {
        
        if fromObject == nil {
            return
        }
        
        let mirrored_object = Mirror(reflecting: fromObject!)
        for (_, attr) in mirrored_object.children.enumerated() {
            if let property_name = attr.label as String! {
                print("Attr \(index): \(property_name) = \(attr.value)")
                
                self.setValue(fromObject!.value(forKey: property_name), forKey: property_name)
            }
        }
    }
}
