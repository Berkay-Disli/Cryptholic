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
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navVM: NavigationViewModel
    @EnvironmentObject var authVM: AuthenticationViewModel
    @ObservedObject var coinVM: CoinsViewModel
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
                if coinVM.showChart {
                    LineChart(chartData: coinVM.lineChartData)
                        .touchOverlay(chartData: coinVM.lineChartData, specifier: "%.0f")
                        .infoBox(chartData: coinVM.lineChartData)
                        //.xAxisGrid(chartData: data)
                        //.yAxisGrid(chartData: data)
                        //.xAxisLabels(chartData: data)
                        //.yAxisLabels(chartData: data)
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
                                    .foregroundColor(coinVM.selectedTimeRange == item ? .red:Color(uiColor: .darkGray))
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
            
            // Add to Fav Button
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
                BigButton(title: authVM.favouriteCoins.contains(coin.id) ? "Remove from Favourites":"Add To Favourites", bgColor: authVM.favouriteCoins.contains(coin.id) ? .red:.black, textColor: authVM.favouriteCoins.contains(coin.id) ? .white:.white)
                    .padding([.horizontal, .top])
                    .animation(.easeInOut, value: authVM.favouriteCoins.contains(coin.id))
            }

            
            
            Spacer()
        }
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
    
    
    static func weekOfData() -> LineChartData {
            
            let data = LineDataSet(dataPoints: [
                LineChartDataPoint(value: 12000, xAxisLabel: "M", description: "Monday"),
                LineChartDataPoint(value: 10000, xAxisLabel: "T", description: "Tuesday"),
                LineChartDataPoint(value: 8000,  xAxisLabel: "W", description: "Wednesday"),
                LineChartDataPoint(value: 17500, xAxisLabel: "T", description: "Thursday"),
                LineChartDataPoint(value: 16000, xAxisLabel: "F", description: "Friday"),
                LineChartDataPoint(value: 11000, xAxisLabel: "S", description: "Saturday"),
                LineChartDataPoint(value: 9000,  xAxisLabel: "S", description: "Sunday")
            ],
            legendTitle: "Steps",
            pointStyle: PointStyle(),
            style: LineStyle(lineColour: ColourStyle(colour: .orange), lineType: .curvedLine))

            let metadata   = ChartMetadata(title: "Step Count", subtitle: "Over a Week")

            let gridStyle  = GridStyle(numberOfLines: 7,
                                       lineColour   : Color(.lightGray).opacity(0.5),
                                       lineWidth    : 1,
                                       dash         : [8],
                                       dashPhase    : 0)

            let chartStyle = LineChartStyle(infoBoxPlacement    : .infoBox(isStatic: false),
                                            infoBoxBorderColour : Color.primary,
                                            infoBoxBorderStyle  : StrokeStyle(lineWidth: 1),

                                            markerType          : .vertical(attachment: .line(dot: .style(DotStyle()))),

                                            xAxisGridStyle      : gridStyle,
                                            xAxisLabelPosition  : .bottom,
                                            xAxisLabelColour    : Color.primary,
                                            xAxisLabelsFrom     : .dataPoint(rotation: .degrees(0)),

                                            yAxisGridStyle      : gridStyle,
                                            yAxisLabelPosition  : .leading,
                                            yAxisLabelColour    : Color.primary,
                                            yAxisNumberOfLabels : 7,

                                            baseline            : .minimumWithMaximum(of: 5000),
                                            topLine             : .maximum(of: 20000),

                                            globalAnimation     : .easeOut(duration: 1))

            return LineChartData(dataSets       : data,
                                 metadata       : metadata,
                                 chartStyle     : chartStyle)

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
