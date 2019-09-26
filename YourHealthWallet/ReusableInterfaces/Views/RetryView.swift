//
//  RetryView.swift
//  
//
//  Created by Shridhar on 6/15/16.
//  Copyright © 2016 costrategix. All rights reserved.
//

import UIKit

class RetryView: View {
    
    var retryLabel = Label()
    var retryImageView = ImageView()

    private func initializeRetryView() {
        retryLabel.text = "RETRY"
        retryImageView.image = UIImage(named: "retry")
    }

}
