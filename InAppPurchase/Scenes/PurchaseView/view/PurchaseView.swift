//
//  PurchaseView.swift
//  InAppPurchase
//
//  Created by Anatolii Shumov on 27.03.2024.
//

import SwiftUI

struct PurchaseView: View {
    @Environment(\.dismiss) var dismiss
    private var viewModel = PurchaseViewModel()
    
    var body: some View {
        ZStack {
            Color.mint .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        ZStack {
                            Circle()
                                .foregroundStyle(Color.black)
                                .frame(width: 26, height: 26)
                            
                            Circle()
                                .foregroundStyle(Color.gray)
                                .frame(width: 24, height: 24)
                            
                            Image(systemName: "xmark")
                                .renderingMode(.template)
                                .foregroundStyle(Color.white)
                        }
                    })
                }
                .padding(.all, 20)
                
                Spacer()
                
                viewModel.products.isEmpty ? AnyView(spinnerView) : AnyView(purchaseView)
            }
        }
        .presentationDragIndicator(.visible)
    }
    
    @ViewBuilder var spinnerView: some View {
        ProgressView()
            .scaleEffect(1.5)
            .tint(.white)
        Spacer()
    }
    
    @ViewBuilder var purchaseView: some View {
        VStack(spacing: 10) {
            Text("Premium")
                .font(.largeTitle)
                .bold()
            
            Text("Get unlimited access for all features")
                .font(.title2)
                .fontWeight(.semibold)
        }
        .foregroundStyle(Color.white)
        
        Spacer()
        
        VStack(spacing: 20) {
            ForEach(viewModel.products, id: \.self) { product in
                PurchaseButton(title: viewModel.productTitle(product)) {
                    viewModel.purchaseButtonTapped(product)
                }
                .disabled(viewModel.isDisable)
            }
            
            Button(action: {
                viewModel.restoreButtonTapped()
            }, label: {
                Text("Restore purchase")
                    .font(.headline)
            })
            .padding(.top, 10)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
    }
}

#Preview {
    PurchaseView()
}
