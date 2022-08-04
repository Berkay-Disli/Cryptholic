//
//  CoinsPage.swift
//  Cryptholic
//
//  Created by Berkay Disli on 3.08.2022.
//

import SwiftUI

struct CoinsPage: View {
    @ObservedObject var coinsVM: CoinsViewModel
    @State private var searchText = ""
    @EnvironmentObject var navVM: NavigationViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    if !coinsVM.coins.coins.isEmpty {
                        if searchText.isEmpty {
                            LazyVStack {
                                ForEach(coinsVM.coins.coins, id:\.self) { item in
                                    CoinListCell(showGraph: false, image: item.icon, name: item.name, symbol: item.symbol, price: item.price, dailyChange: item.priceChange1d ?? 0)
                                        .padding(.bottom, 14)
                                }
                            }
                            .padding(.horizontal)
                            .transition(AnyTransition.opacity.animation(.easeInOut))
                        } else {
                            LazyVStack {
                                ForEach(coinsVM.coins.coins.filter { $0.name.contains(searchText)}, id:\.self) { item in
                                    CoinListCell(showGraph: false, image: item.icon, name: item.name, symbol: item.symbol, price: item.price, dailyChange: item.priceChange1d ?? 0)
                                }
                            }
                            .padding(.horizontal)
                            .transition(AnyTransition.opacity.animation(.easeInOut))
                        }
                    } else {
                        ProgressView()
                    }
                }
                .searchable(text: $searchText, prompt: "Search for a coin")
                .scrollDismissesKeyboard(.immediately)
                
            }
            .onAppear {
                navVM.openTabBar()
            }
            .navigationTitle("Coins")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "line.3.horizontal")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "arrow.clockwise")
                        .onTapGesture {
                            coinsVM.getData()
                        }
                }
            }
        }
    }
}

struct CoinsPage_Previews: PreviewProvider {
    static var previews: some View {
        CoinsPage(coinsVM: CoinsViewModel())
            .environmentObject(NavigationViewModel())
    }
}
