//
//  ViewController.swift
//  InAppPurchases
//
//  Created by Stefan Markovic on 8/9/17.
//  Copyright © 2017 Stefan Markovic. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import StoreKit

//shared seceret we got it from apple developer site specific to our app
var sharedSecret = "83b14f7e5f6c4a549d76b045c78ce394"


class ViewController: UIViewController {
    
    //keeping track of the purchases
    var money: Int!
    let bundleID = "com.stefanmarkovic.InAppPurchases"
    var dollar10 = RegisteredPurchases.Dollars10
    var removeAdds = RegisteredPurchases.RemoveAdds

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func consumable1(_ sender: UIButton) {
    }
    
    @IBAction func consumable2(_ sender: UIButton) {
    }
    
    @IBAction func renewable(_ sender: UIButton) {
    }
    
    @IBAction func nonRenewable(_ sender: UIButton) {
    }
    
    func getInfo(purchase: RegisteredPurchases){
        
        NetworkAcitvityIndicatorManager.networkOperationStarted()
        SwiftyStoreKit.retrieveProductsInfo([bundleID + "." + purchase.rawValue]) { (result) in
            NetworkAcitvityIndicatorManager.networkOperationFinished()
            
            self.showAlert(alert: self.alertForProductRetrivalInfo(result: result))
        }
    }

    func purchase(purchase: RegisteredPurchases){
        NetworkAcitvityIndicatorManager.networkOperationStarted()
        SwiftyStoreKit.purchaseProduct(bundleID + "." + purchase.rawValue) { (result) in
            NetworkAcitvityIndicatorManager.networkOperationFinished()
            
            if case .success(let product) = result {
                
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                self.showAlert(alert: self.alertForPurchaseResult(result: result))
            }
        }
    }
    
    func restorePurchases(){
        NetworkAcitvityIndicatorManager.networkOperationStarted()
        SwiftyStoreKit.restorePurchases(atomically: true) {result in
            NetworkAcitvityIndicatorManager.networkOperationFinished()
            
            for product in result.restoredPurchases {
                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
            }
            
            self.showAlert(alert: self.alertForRestorePurchases(result: result))

        }
        
        
    }
    
    
    func verifyReceipts(){
        NetworkAcitvityIndicatorManager.networkOperationFinished()
        SwiftyStoreKit.verifyReceipt(using: AppleReceiptValidator() as ReceiptValidator, password: sharedSecret, completion: {
            result in
            NetworkAcitvityIndicatorManager.networkOperationFinished()
            
            self.showAlert(alert: self.alertForFerifyReceipt(result: result))

        })
    }
    
    func verifyPurchase(){
        NetworkAcitvityIndicatorManager.networkOperationStarted()
        SwiftyStoreKit.verifyReceipt(using: AppleReceiptValidator() as ReceiptValidator, password: sharedSecret, completion: {
            result in
            NetworkAcitvityIndicatorManager.networkOperationFinished()
        })
        
    }
    
   
    
    
    
    
    
    
}











