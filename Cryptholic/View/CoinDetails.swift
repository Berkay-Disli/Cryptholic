//
//  CoinDetails.swift
//  Cryptholic
//
//  Created by Berkay Disli on 4.08.2022.
//

import SwiftUI
import Kingfisher
import SwiftUICharts

struct CoinDetails: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navVM: NavigationViewModel
    @EnvironmentObject var authVM: AuthenticationViewModel
    @ObservedObject var coinVM: CoinsViewModel
    let coin: Coin
    @State private var gridEnabled = false
    @State private var notificationsEnabled = false
    
    var body: some View {
        VStack {
            // MARK: Coin Info Header
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
                
                // MARK: Price and Buttons
                HStack {
                    Text("USD \(Double(round(10000 * coin.price) / 10000).formatted())")
                        .font(.system(size: 32))
                        .fontWeight(.medium)
                        .foregroundColor(Color("black"))
                    Spacer()
                    
                    //Buttons
                    HStack {
                        Button {
                            withAnimation(.easeInOut) {
                                notificationsEnabled.toggle()
                            }
                        } label: {
                            IconButton(iconName: "bell", enabledIconName: "bell.fill", notificationsEnabled: $notificationsEnabled)
                        }
                        
                        Menu {
                            Menu("Color") {
                                ForEach(ChartColors.allCases, id:\.self) { item in
                                    Button {
                                        coinVM.changeChartColor(color: item.color)
                                        coinVM.getCoinDetailsData(coin: coin)
                                    } label: {
                                        Text(item.title)
                                    }
                                }
                            }
                            Toggle("Grid", isOn: $gridEnabled)
                        } label: {
                            IconButton(iconName: "slider.vertical.3", enabledIconName: "slider.vertical.3", notificationsEnabled: .constant(false))
                        }
                    }
                }
                
                // MARK: Price Change Info
                if let priceRatio1d = coin.priceChange1d {
                    HStack{
                        Image(systemName: priceRatio1d >= 0 ? "arrow.up.right":"arrow.down.right")
                        // Some math rocks in here :)
                        if abs(coin.price * priceRatio1d / 100) >= 0.0001 {
                            Text("\(String(format: "%.4f", (coin.price * priceRatio1d / 100)))")
                        }
                        Text("(\(priceRatio1d.formatted())%)")
                    }
                    .fontWeight(.medium)
                    .foregroundColor(priceRatio1d >= 0 ? .green:.red)
                }
                
            }
            .padding(.horizontal)
            
            // MARK: Graph
            VStack {
                if coinVM.showChart {
                    LineChart(chartData: coinVM.lineChartData)
                        .touchOverlay(chartData: coinVM.lineChartData, specifier: "%.0f")
                        .infoBox(chartData: coinVM.lineChartData)
                        .if(gridEnabled) { $0.xAxisGrid(chartData: coinVM.lineChartData)
                        }
                        .if(gridEnabled) { $0.yAxisGrid(chartData: coinVM.lineChartData)
                        }
                        //.yAxisGrid(chartData: coinVM.lineChartData)
                        //.xAxisLabels(chartData: coinVM.lineChartData)
                        //.yAxisLabels(chartData: coinVM.lineChartData)
                    .frame(width: UIScreen.main.bounds.width, height: 500)
                    .offset(y: -40)
                } else {
                    Rectangle().fill(.white)
                        .frame(width: UIScreen.main.bounds.width, height: 500)
                        .offset(y: -40)
                }
                HStack {
                    ForEach(TimezoneRanges.allCases, id:\.self) { item in
                        Button {
                            coinVM.setTimeZoneRange(range: item)
                            coinVM.getCoinDetailsData(coin: coin)
                        } label: {
                            HStack {
                                Spacer()
                                Text(item.urlValue.uppercased())
                                    .font(.title3).fontWeight(.medium)
                                    .foregroundColor(coinVM.selectedTimeRange == item ? .red:Color(uiColor: colorScheme == .dark ? .lightGray:.darkGray))
                                    .padding(.top, 4)
                                Spacer()
                            }
                        }

                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 4)
            
            Divider()
                .padding(.top)
            
            // MARK: Add to Fav Button
            Button {
                if authVM.favouriteCoins.contains(coin.id) {
                    authVM.removeFromFavourites(coin: coin)
                } else {
                    authVM.addToFavourites(coin: coin)
                }
                authVM.getUserInfo { _ in
                    print("Favourites updated.")
                }
            } label: {
                BigButton(title: authVM.favouriteCoins.contains(coin.id) ? "Remove from Favourites":"Add To Favourites", bgColor: authVM.favouriteCoins.contains(coin.id) ? .red:Color("black"), textColor: authVM.favouriteCoins.contains(coin.id) ? Color("white"):Color("white"))
                    .padding([.horizontal, .top])
                    .animation(.easeInOut, value: authVM.favouriteCoins.contains(coin.id))
            }

            
            
            Spacer()
        }
        .background(Color("bg"))
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            navVM.closeTabBar()
            coinVM.getCoinDetailsData(coin: coin)
        })
        .onDisappear(perform: {
            coinVM.resetLineChartData()
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
            CoinDetails(coinVM: CoinsViewModel(), coin: Coin(id: "bitcoin", icon: "https://static.coinstats.app/coins/1650455588819.png", name: "Bitcoin", symbol: "BTC", rank: 1, price: 22008.51, priceBtc: 1, volume: 0, marketCap: 0, availableSupply: 0, totalSupply: 0, priceChange1h: 0, priceChange1d: -2.58, priceChange1w: 0, websiteURL: "", twitterURL: "", exp: [""], contractAddress: "", decimals: 0, redditURL: ""))
                .environmentObject(NavigationViewModel())
                .environmentObject(AuthenticationViewModel())
        }
    }
}

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}
