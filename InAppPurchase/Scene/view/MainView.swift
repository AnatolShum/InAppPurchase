//
//  MainView.swift
//  InAppPurchase
//
//  Created by Anatolii Shumov on 27.03.2024.
//

import SwiftUI

struct MainView: View {
    private var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(Color.blue)
                
                Button(action: {
                    viewModel.subscribe()
                }, label: {
                    Text("Subscribe")
                        .foregroundStyle(Color.white)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                })
            }
            .frame(height: 44)
        }
        .padding()
    }
}

#Preview {
    MainView()
}
