//
//  Home.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    // Watchlist Section -- will automatically show the first 3 coins in the data.
                    VStack(alignment: .leading) {
                        Text("Watchlist")
                            .font(.title2).fontWeight(.medium)
                            .padding()
                        VStack {
                            ForEach(1...3, id:\.self) { _ in
                                CoinListCell(showGraph: true, image: "bitcoinsign.circle.fill", name: "Bitcoin", symbol: "BTC", price: 40981.51, dailyChange: 5.96)
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
                                ForEach(1...4, id:\.self) { _ in
                                    VStack(spacing: 8) {
                                        HStack {
                                            Image(systemName: "bitcoinsign.circle.fill")
                                                .foregroundColor(.orange)
                                                .font(.system(size: 45))
                                            Text("Bitcoin")
                                                .fontWeight(.medium)
                                        }
                                        HStack {
                                            Text("BTC")
                                                .bold()
                                            Text("40,981.51")
                                                .foregroundColor(.gray)
                                        }
                                        .font(.footnote)
                                        
                                        Text("27.38%")
                                            .font(.title)
                                            
                                            .foregroundColor(.red)
                                    }
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.3)))
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
        Home()
    }
}
