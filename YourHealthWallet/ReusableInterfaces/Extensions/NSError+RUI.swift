//
//  NSErrorAdditions.swift
//  Juicer
//
//  Created by SrikanthKV on 2/20/15.
//  Copyright (c) 2015 Digital Juice. All rights reserved.
//

import UIKit

public extension NSError {
    
    public func isNoConnectionError() -> Bool {
        return self.domain == NSURLErrorDomain && self.code == NSURLErrorNotConnectedToInternet
    }
    
    public func isFileNotFoundError() -> Bool {
        return self.domain == NSCocoaErrorDomain && self.code == NSFileReadNoSuchFileError
    }
    
}