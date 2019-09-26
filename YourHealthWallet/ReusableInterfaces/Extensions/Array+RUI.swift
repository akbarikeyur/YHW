//
//  Array+RUI.swift
//  Juicer
//
//  Created by Srikanth KV on 09/06/15.
//  Copyright (c) 2015 Digital Juice. All rights reserved.
//

import UIKit

extension Array {
  mutating func removeObject<U: Equatable>(object: U) -> Bool {
    for (idx, objectToCompare) in self.enumerated() {
      if let to = objectToCompare as? U {
        if object == to {
            self.remove(at: idx)
          return true
        }
      }
    }
    return false
  }
    
    func containsObject<U: Equatable>(object : U) -> Bool {
        for (_, objectToCompare) in self.enumerated() {
            if let to = objectToCompare as? U {
                if object == to {
                    return true
                }
            }
        }
        return false
    }
    
    func before(value1: String, value2: String) -> Bool {
         return value1 < value2;
    }

    
}
