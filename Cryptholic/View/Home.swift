//
//  Home.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import SwiftUI

struct Home: View {
    @ObservedObject var coinsVM: CoinsViewModel

    var body: some View {
        NavigationView {
            RefreshableScrollView {
                LazyVStack {
                    // Watchlist Section -- will automatically show the first 3 coins in the data.
                    VStack(alignment: .leading) {
                        Text("Watchlist")
                            .font(.title2).fontWeight(.medium)
                            .padding()
                        VStack {
                            ForEach(coinsVM.coins.coins.prefix(3), id:\.self) { item in
                                CoinListCell(showGraph: true, image: item.icon, name: item.name, symbol: item.symbol, price: item.price, dailyChange: item.priceChange1d ?? 0)
                            }
                        }
                        .padding(.horizontal)
                        
                        Divider()
                    }
                    
                    
                    // Top Movers Section -- Based on the highest weekly change ratio.
                    VStack(alignment: .leading) {
                        Text("Top Movers")
                            .font(.title2).fontWeight(.medium)
                            .padding()
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(coinsVM.coins.coins.sorted{$0.priceChange1d ?? 0 > $1.priceChange1d ?? 0}.prefix(5), id:\.self) { item in
                                    TopMoversCell(icon: item.icon, name: item.name, symbol: item.symbol, price: item.price, priceChange: item.priceChange1d ?? 0)
                                }
                                .padding(.horizontal, 2)
                            }
                            .padding(.horizontal)
                        }
                        Divider()
                            .padding(.top)
                            .padding(.bottom, 8)
                    }
                    
                    // News Section -- No function for now :)
                    VStack(alignment: .leading) {
                        ForEach(1...3, id:\.self) { _ in
                            VStack(alignment: .leading) {
                                // News Publisher
                                HStack {
                                    Image(systemName: "bitcoinsign.circle.fill")
                                        .font(.system(size: 45))
                                        .foregroundColor(.blue)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Cryptoholic")
                                            .font(.headline)
                                        Text("News  -  August 2")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "slider.vertical.3")
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal)
                                
                                // News Photo
                                Image("eth")
                                    .resizable()
                                    .scaledToFit()
                                
                                // News Content
                                VStack(spacing: 8) {
                                    Text("Etherium's Merge is Coming and the Stakes Couldn't Be Higher")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                    Text("The most important upgrade in blockchain history is slated for August.")
                                }
                                .padding()
                                
                                // Like
                                HStack {
                                    Image(systemName: "heart")
                                    Text("1.6K")
                                }
                                .fontWeight(.medium)
                                .padding(.horizontal)
                                
                                Divider()
                                    .padding(.vertical, 4)
                            }
                        }
                        
                        
                    }
                }
            } onRefresh: {
                coinsVM.getData()
            }
            .navigationTitle("Home")
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(coinsVM: CoinsViewModel())
    }
}
