//
//  ExtensionViewController.swift
//  InAppPurchases
//
//  Created by Stefan Markovic on 8/9/17.
//  Copyright © 2017 Stefan Markovic. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit

extension ViewController {
    
    func alertWithTitle(title: String, message: String) -> UIAlertController{
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        return alert
    }
    
    func showAlert(alert: UIAlertController){
        guard let _ = self.presentedViewController else {
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        
    }
    
    func alertForProductRetrivalInfo(result: RetrieveResults) -> UIAlertController  {
        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            return alertWithTitle(title: product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
        }
            
        else if let invalidProductID = result.invalidProductIDs.first {
            
            return alertWithTitle(title: "Could not retrive product info", message: "Invalid product identifier: \(invalidProductID)")
        }
        
        else {
            let errorString = result.error?.localizedDescription ?? "Unknown error. Please contact support"
            return alertWithTitle(title: "Could not retrive product info", message: errorString)
        }
    }
    
    func alertForPurchaseResult(result: PurchaseResult) -> UIAlertController {
        switch result {
        case .success(let product):
            
            print("Purchase successful: \(product.productId)")
            
            return alertWithTitle(title: "Thank you", message: "Purchase completed")
            
        case .error(let error):
            
            print("Purchase failed: \(error)")
            
            return alertWithTitle(title: "Purchase failed", message: "Please contact our support")
            
        }

    }
    
    func alertForRestorePurchases(result: RestoreResults) -> UIAlertController {
        
        if result.restoreFailedPurchases.count > 0 {
            print("Restore failed: \(result.restoreFailedPurchases)")
            return alertWithTitle(title: "Restore failed", message: "Unknown error please contact support")
        }
        else if result.restoredPurchases.count > 0 {
            
            return alertWithTitle(title: "Purchases restored", message: "All purchases restored")
        }
        else {
            return alertWithTitle(title: "Nothing to restore", message: "No previous purchases were made")
        }
        
        
    }
    
    func alertForFerifyReceipt(result: VerifyReceiptResult) -> UIAlertController {
        
        switch result {
            
        case .success(let receipt):
            return alertWithTitle(title: "My receipt is verified: \(receipt)", message: "Receipt verified remotely")
        case .error(let error):
            switch error {
            case .noReceiptData:
                return alertWithTitle(title: "Receipt verification", message: "No recepit data found")
            default:
                return alertWithTitle(title: "Receipt verification", message: "Receipt verification failed")
                
            }
            
        }

    }
    
    func alertForVerifiedSubsciption(result: VerifySubscriptionResult) -> UIAlertController {
        
        switch result {
            
        case .purchased(let expiryDate):
            return alertWithTitle(title: "Product is purchased", message: "Product is valid until \(expiryDate)")
        case .notPurchased:
            return alertWithTitle(title: "Product is not purchased", message: "This product has never been putchased")
        case .expired(let expiryDate):
            return alertWithTitle(title: "Product is expired", message: "Product is expired since \(expiryDate)")
            
        }

    }
    
    func alertForVerifiedPurchase(result: VerifyPurchaseResult) -> UIAlertController {
        
        switch result {
        case .purchased:
            return alertWithTitle(title: "Product is purchased", message: "Product will not expire")
        case .notPurchased:
            return alertWithTitle(title: "Product is not purchased", message: "Product has never been purchased")
        }
        
    }
    
    
    
    

    
    
}
