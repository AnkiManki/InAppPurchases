//
//  NetworkActivityIndicator.swift
//  InAppPurchases
//
//  Created by Stefan Markovic on 8/9/17.
//  Copyright © 2017 Stefan Markovic. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit

//checking if we have network connection
class NetworkAcitvityIndicatorManager: NSObject {
    
    //it will add numbers if connection is good and it will decrese if its bad
    private static var loadingCount = 0
    
    class func networkOperationStarted(){
        
        if loadingCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        loadingCount += 1
    }
    
    class func networkOperationFinished(){
        if loadingCount > 0 {
            loadingCount -= 1
        }
        if loadingCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
}
