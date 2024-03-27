//
//  PurchaseViewModel.swift
//  InAppPurchase
//
//  Created by Anatolii Shumov on 27.03.2024.
//

import Foundation
import StoreKit
import Combine

@Observable
class PurchaseViewModel {
    var products: [SKProduct] = []
    var isDisable: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        PurchaseManager.shared.initialize()
        
        PurchaseManager.shared.productsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                self?.products = products
            }
            .store(in: &cancellables)
        
        PurchaseManager.shared.failedStatusPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isDisable = false
            }
            .store(in: &cancellables)
    }
    
    func purchaseButtonTapped(_ product: SKProduct) {
        print(product.productIdentifier)
        PurchaseManager.shared.purchase(product.productIdentifier)
        isDisable = true
    }
    
    func restoreButtonTapped() {
        print("Restore Button Tapped")
        PurchaseManager.shared.restorePurchases()
    }
    
    func productTitle(_ product: SKProduct) -> String {
        return "\(product.localizedTitle) \(product.price)"
    }
}
