//
//  AppDelegate.swift
//  InAppPurchase
//
//  Created by Anatolii Shumov on 27.03.2024.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        fetchReceipt()
        
        return true
    }
    
    func fetchReceipt() {
        if let receiptUrl = Bundle.main.appStoreReceiptURL,
           FileManager.default.fileExists(atPath: receiptUrl.path()) {
            do {
                let receiptData = try Data(contentsOf: receiptUrl, options: .alwaysMapped)
                let receiptString = receiptData.base64EncodedString()
                print(receiptString)
            } catch {
                print("Could not read receipt data \(error.localizedDescription)")
            }
        }
    }
}
