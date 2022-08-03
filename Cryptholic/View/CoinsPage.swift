//
//  CoinsPage.swift
//  Cryptholic
//
//  Created by Berkay Disli on 3.08.2022.
//

import SwiftUI

struct CoinsPage: View {
    @ObservedObject var coinsVM: CoinsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("No search bar for now :)")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(.gray)
                    .cornerRadius(10)
                    .padding()
                
                ScrollView {
                    LazyVStack {
                        ForEach(coinsVM.coins.coins, id:\.self) { item in
                            CoinListCell(showGraph: false, image: "bitcoinsign.circle.fill", name: item.name, symbol: item.symbol, price: item.price, dailyChange: item.priceChange1d ?? 0)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Coins")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "line.3.horizontal")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "bell")
                }
            }
        }
    }
}

struct CoinsPage_Previews: PreviewProvider {
    static var previews: some View {
        CoinsPage(coinsVM: CoinsViewModel())
    }
}
