//
//  PurchaseManager.swift
//  InAppPurchase
//
//  Created by Anatolii Shumov on 27.03.2024.
//

import StoreKit
import Combine

class PurchaseManager: NSObject {
    static let shared = PurchaseManager()
    
    let monthlyProductId = "AnatolShum.com.icloud.InAppPurchase.monthly"
    let yearlyProductId = "AnatolShum.com.icloud.InAppPurchase.yearly"
    
    private var productsRequest = SKProductsRequest()
    private var products: [SKProduct] = []
    
    var productsPublisher = PassthroughSubject<[SKProduct], Never>()
    var failedStatusPublisher = PassthroughSubject<Void, Never>()
    
    func initialize() {
        SKPaymentQueue.default().add(self)
        fetchAvailableProducts()
    }
    
    private func fetchAvailableProducts() {
        productsRequest.cancel()
        
        let productIds = Set([monthlyProductId, yearlyProductId])
        productsRequest = SKProductsRequest(productIdentifiers: productIds)
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    func purchase(_ productId: String) {
        guard canMakePayments() else { return }
        
        let product = products.first { $0.productIdentifier == productId }
        guard let product else { return }
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    private func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
}

extension PurchaseManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        response.invalidProductIdentifiers.forEach { id in
            print("Invalid product identifier: \(id)")
        }
        
        products = response.products
        productsPublisher.send(response.products)
    }
    
    func request(_ request: SKRequest, didFailWithError error: any Error) {
        print("Failed to load products: \(error.localizedDescription)")
    }
    
}

extension PurchaseManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .restored:
                print("Transaction restored successful")
                SKPaymentQueue.default().finishTransaction(transaction)
            case .purchased:
                print("Transaction purchased successful")
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                if let error = transaction.error {
                    print("Transaction failed with error: \(error.localizedDescription)")
                } else {
                    print("Transaction canceled by the user")
                }
                failedStatusPublisher.send()
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
    
    
}
