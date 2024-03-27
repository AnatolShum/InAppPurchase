//
//  PurchaseButton.swift
//  InAppPurchase
//
//  Created by Anatolii Shumov on 27.03.2024.
//

import SwiftUI

struct PurchaseButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .foregroundStyle(Color.blue)
            
            Button(action: {
                action()
            }, label: {
                HStack {
                    Text("7 days free then")
                        .font(.subheadline)
                    Text(title)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(Color.white)
            })
        }
        .frame(height: 50)
    }
}

#Preview {
    PurchaseButton(title: "Button") {
        print("Tapped")
    }
}
