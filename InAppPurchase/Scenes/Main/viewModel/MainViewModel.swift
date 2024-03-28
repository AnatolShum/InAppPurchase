//
//  MainViewModel.swift
//  InAppPurchase
//
//  Created by Anatolii Shumov on 27.03.2024.
//

import Foundation

@Observable
class MainViewModel { 
    let productIds: [String] = [PurchaseManager.shared.monthlyProductId, PurchaseManager.shared.yearlyProductId]
}
