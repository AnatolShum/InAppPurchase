//
//  MainViewButton.swift
//  InAppPurchase
//
//  Created by Anatolii Shumov on 28.03.2024.
//

import SwiftUI

struct MainViewButton: View {
    @Binding var showSheet: Bool
    
    let title: String
    let sheetView: AnyView
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.blue)
            
            Button(action: {
                showSheet.toggle()
            }, label: {
                Text(title)
                    .foregroundStyle(Color.white)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
            })
            .sheet(isPresented: $showSheet) {
                sheetView
            }
        }
        .frame(height: 44)
    }
}
