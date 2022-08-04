//
//  CoinDetails.swift
//  Cryptholic
//
//  Created by Berkay Disli on 4.08.2022.
//

import SwiftUI
import Kingfisher

struct CoinDetails: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navVM: NavigationViewModel
    let coin: Coin
    
    var body: some View {
        VStack {
            // Coin Info Header
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(coin.name)
                        .font(.title3)
                        .foregroundColor(.gray)
                    KFImage(URL(string: coin.icon))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                }
                .padding(.top)
                
                // Price and Buttons
                HStack {
                    Text("USD \(Double(round(100 * coin.price) / 100).formatted())")
                        .font(.system(size: 32))
                        .fontWeight(.medium)
                    Spacer()
                    //Buttons
                    HStack {
                        Button {
                            // notify me?
                        } label: {
                            IconButton(iconName: "bell")
                        }
                        
                        Button {
                            // some settings?
                        } label: {
                            IconButton(iconName: "slider.vertical.3")
                        }
                    }
                }
                
                // Price Change Info
                if let priceRatio1d = coin.priceChange1d {
                    HStack{
                        Image(systemName: priceRatio1d >= 0 ? "arrow.up.right":"arrow.down.right")
                        // Some math rocks in here :)
                        Text("\(String(format: "%.2f", (coin.price * priceRatio1d / 100)))")
                        Text("(\(priceRatio1d.formatted())%)")
                    }
                    .fontWeight(.medium)
                    .foregroundColor(priceRatio1d >= 0 ? .green:.red)
                }
                
            }
            .padding(.horizontal)
            
            // Graph
            VStack {
                Color.blue.opacity(0.15)
                    .frame(height: 500)
                    .padding(.top, 8)
                HStack {
                    ForEach(TimezoneRanges.allCases, id:\.self) { item in
                        HStack {
                            Spacer()
                            Text(item.shortTitle)
                                .font(.title3).fontWeight(.medium)
                                .foregroundColor(Color(uiColor: .darkGray))
                                .padding(.top, 4)
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 4)
            
            Divider()
            
            // Add to Fav Button
            Button {
                
            } label: {
                Text("Add to Watchlist")
                    .font(.title3).fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity).frame(height: 66)
                    .background(.black)
                    .cornerRadius(100)
                    .padding([.horizontal, .top])
            }

            
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            navVM.closeTabBar()
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
        .navigationBarBackButtonHidden()
        
    }
}

struct CoinDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoinDetails(coin: Coin(id: "", icon: "https://static.coinstats.app/coins/1650455588819.png", name: "Bitcoin", symbol: "BTC", rank: 1, price: 22008.51, priceBtc: 1, volume: 0, marketCap: 0, availableSupply: 0, totalSupply: 0, priceChange1h: 0, priceChange1d: -2.58, priceChange1w: 0, websiteURL: "", twitterURL: "", exp: [""], contractAddress: "", decimals: 0, redditURL: ""))
                .environmentObject(NavigationViewModel())
        }
    }
}
