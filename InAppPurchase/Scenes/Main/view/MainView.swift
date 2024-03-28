//
//  MainView.swift
//  InAppPurchase
//
//  Created by Anatolii Shumov on 27.03.2024.
//

import SwiftUI
import StoreKit

struct MainView: View {
    private var viewModel = MainViewModel()
    @State private var showCustomSheet = false
    @State private var showUISheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            MainViewButton(showSheet: $showCustomSheet, title: "Custom subscribe", sheetView: AnyView(PurchaseView()))
            
            MainViewButton(showSheet: $showUISheet, title: "SwiftUI subscribe", sheetView: AnyView(
                StoreView(ids: viewModel.productIds)
                .background(.background.secondary)
                .storeButton(.visible, for: .restorePurchases)
                .presentationDetents([.fraction(0.4)])
            ))
        }
        .padding()
    }
}

#Preview {
    MainView()
}
