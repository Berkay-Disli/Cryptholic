//
//  Home.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import SwiftUI

struct Home: View {
    @ObservedObject var coinsVM: CoinsViewModel
    @EnvironmentObject var navVM: NavigationViewModel
    @EnvironmentObject var authVM: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            RefreshableScrollView {
                LazyVStack {
                    // Watchlist Section -- will automatically show the first 3 coins in the data.
                    VStack(alignment: .leading) {
                        Text("Watchlist")
                            .font(.title2).fontWeight(.medium)
                            .padding()
                            .foregroundColor(Color("black"))
                        VStack {
                            if !authVM.filtered.isEmpty {
                                ScrollView {
                                    ForEach(authVM.filtered.prefix(3), id:\.self) { coin in
                                        NavigationLink {
                                            CoinDetails(coinVM: coinsVM, coin: coin)
                                        } label: {
                                            CoinListCell(showGraph: false, image: coin.icon, name: coin.name, symbol: coin.symbol, price: coin.price, dailyChange: coin.priceChange1d ?? 0)
                                                .padding(.bottom, 14)
                                        }
                                    }
                                    .animation(.easeInOut, value: authVM.filtered)
                                    .transition(AnyTransition.opacity.animation(.easeInOut))
                                    
                                    if authVM.filtered.prefix(3).count != authVM.filtered.count {
                                        let itemsLeft = authVM.filtered.count - authVM.filtered.prefix(3).count
                                        Text("\(itemsLeft) more coins")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                            .padding(.top, -8)
                                    }
                                }
                            } else {
                                VStack(spacing: 4) {
                                    Image(colorScheme == .dark ? "logoFinalBlack":"logoFinal")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 45)
                                        .padding(.bottom, 8)
                                    Text("Your watchlist is empty.")
                                        .foregroundColor(Color("black"))
                                    Text("Add coins to your favourites.")
                                        .foregroundColor(.red)
                                }
                                .font(.title3)
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .transition(AnyTransition.opacity.animation(.easeInOut))
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
                            .foregroundColor(Color("black"))
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(coinsVM.coins.coins.sorted{fabs($0.priceChange1d ?? 0) > fabs($1.priceChange1d ?? 0)}.prefix(5), id:\.self) { item in
                                    NavigationLink {
                                        CoinDetails(coinVM: coinsVM, coin: item)
                                    } label: {
                                        TopMoversCell(icon: item.icon, name: item.name, symbol: item.symbol, price: item.price, priceChange: item.priceChange1d ?? 0)
                                    }

                                }
                                .padding(.horizontal, 2)
                            }
                            .padding(.horizontal)
                        }
                        Divider()
                            .padding(.vertical)
                    }
                    
                    // MARK: News Section -- No function for now :)
                    VStack(alignment: .leading) {
                        ForEach(1...3, id:\.self) { _ in
                            VStack(alignment: .leading) {
                                // News Publisher
                                HStack {
                                    Image(colorScheme == .dark ? "logoFinalBlack":"logoFinal")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 45, height: 45)
                                        .clipShape(Circle())
                                        
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Cryptoholic")
                                            .font(.headline)
                                            .foregroundColor(Color("black"))
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
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width, height: 262)
                                
                                // News Content
                                VStack(spacing: 8) {
                                    Text("Etherium's Merge is Coming and the Stakes Couldn't Be Higher")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                    Text("The most important upgrade in blockchain history is slated for August.")
                                }
                                .foregroundColor(Color("black"))
                                .padding()
                                
                                // Like
                                HStack {
                                    Image(systemName: "heart")
                                        .foregroundColor(.red)
                                    Text("1.6K")
                                        .foregroundColor(Color("black"))

                                }
                                .fontWeight(.medium)
                                .padding(.horizontal)
                                
                                Divider()
                                    .padding(.vertical, 4)
                            }
                        }
                        
                        
                    }
                }
                .onAppear {
                    //self.authVM.filtered.removeAll(keepingCapacity: false)
                    authVM.getUserInfo { success in
                        if success {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                var filteredArray = [Coin]()
                                for coinId in authVM.favouriteCoins {
                                    let result = coinsVM.coins.coins.filter { $0.id == coinId }
                                    filteredArray.append(result.first!)
                                }
                                self.authVM.filtered = filteredArray
                            }
                        }
                    }
                    navVM.openTabBar()
                    
                }
                .background(Color("bg"))
                
            }
            onRefresh: {
                coinsVM.getData()
                authVM.getUserInfo { success in
                    if success {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            var filteredArray = [Coin]()
                            for coinId in authVM.favouriteCoins {
                                let result = coinsVM.coins.coins.filter { $0.id == coinId }
                                guard let firstItem = result.first else {
                                    print("ERROR: TabManager->onAppear")
                                    return
                                }
                                filteredArray.append(firstItem)
                            }
                            self.authVM.filtered = filteredArray
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom) // Optional
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // open sidemenu --- ADD Drag Gesture
                        withAnimation(.easeInOut) {
                            navVM.openSideMenu()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(Color("black"))
                    }

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
            .environmentObject(NavigationViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
