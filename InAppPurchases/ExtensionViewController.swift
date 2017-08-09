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
    
    func alertForProductRetrivalInfo(result: RetrieveResults){
        
        
        
    }
    
    
}
