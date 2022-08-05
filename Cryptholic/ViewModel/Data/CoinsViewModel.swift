//
//  CoinsViewModel.swift
//  Cryptholic
//
//  Created by Berkay Disli on 3.08.2022.
//

import Foundation
import SwiftUICharts
import SwiftUI

class CoinsViewModel: ObservableObject {
    @Published var coins = Coins(coins: [Coin]())
    @Published var selectedTimeRange: TimezoneRanges = .day
    @Published var coinPrices = CoinPrices(chart: [[Double]()])
    // Created an empty Coin object to start with
    var coinToShowDetails = Coin(id: "", icon: "", name: "", symbol: "", rank: 0, price: 0, priceBtc: 0, volume: 0, marketCap: 0, availableSupply: 0, totalSupply: 0, priceChange1h: 0, priceChange1d: 0, priceChange1w: 0, websiteURL: "", twitterURL: "", exp: [""], contractAddress: "", decimals: 0, redditURL: "")
    @Published var lineChartData = LineChartData(dataSets: LineDataSet(dataPoints: [LineChartDataPoint(value: 0, xAxisLabel: "", description: "")], legendTitle: "LegendTitle", pointStyle: PointStyle(), style: LineStyle(lineColour: ColourStyle(colour: .green), lineType: .curvedLine)), metadata: ChartMetadata(title: "Title", subtitle: "Subtitle", titleFont: .callout, titleColour: .orange, subtitleFont: .caption, subtitleColour: .blue), chartStyle: LineChartStyle(infoBoxPlacement: .infoBox(isStatic: false), infoBoxBorderColour: .primary, infoBoxBorderStyle: StrokeStyle(lineWidth: 1), markerType: .vertical(attachment: .line(dot: .style(DotStyle()))), xAxisGridStyle: GridStyle(numberOfLines: 7, lineColour: Color(.lightGray).opacity(0.5), lineWidth: 1, dash: [8], dashPhase: 0), xAxisLabelPosition: .bottom, xAxisLabelColour: .primary, xAxisLabelsFrom: .dataPoint(rotation: .degrees(0)), yAxisGridStyle: GridStyle(numberOfLines: 7, lineColour: Color(.lightGray).opacity(0.5), lineWidth: 1, dash: [8], dashPhase: 0), yAxisLabelPosition: .leading, yAxisNumberOfLabels: 7, baseline: .minimumWithMaximum(of: 0), topLine: .maximum(of: 15), globalAnimation: .easeInOut(duration: 1)))
    
    @Published var showGraph = false
    private var dataPointsArray: [LineChartDataPoint] = []
    
    init() {
        getData()
    }
    
    func getData() {
        coins = Coins(coins: [Coin]())
        guard let url = URL(string: "https://api.coinstats.app/public/v1/coins") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { return }

            do {
                let result = try JSONDecoder().decode(Coins.self, from: data)
                DispatchQueue.main.async {
                    self.coins = result
                }
            } catch let err {
                print(err.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    func getCoinDetailsData(coin: Coin) {
        guard let url = URL(string: "https://api.coinstats.app/public/v1/charts?period=\(selectedTimeRange.urlValue)&coinId=\(coin.id)") else { return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, error == nil else { return }
        
            do {
                let result = try JSONDecoder().decode(CoinPrices.self, from: data)
                
                DispatchQueue.main.async {
                    self.coinPrices = result
                    var baseline = 100000000000.0
                    var topline = 0.0
                    self.dataPointsArray.removeAll(keepingCapacity: false)
                    for valueSet in self.coinPrices.chart {
                        self.dataPointsArray.append(LineChartDataPoint(value: valueSet[1] , xAxisLabel: "a", description: "AAA"))
                        if valueSet[1] >= topline {
                            topline = valueSet[1]
                        }
                        if valueSet[1] <= baseline {
                            baseline = valueSet[1]
                        }
                    }
                    
                    self.lineChartData = LineChartData(dataSets: LineDataSet(dataPoints: self.dataPointsArray, legendTitle: "LegendTitle", pointStyle: PointStyle(), style: LineStyle(lineColour: ColourStyle(colour: .orange), lineType: .curvedLine)), metadata: ChartMetadata(title: "Title", subtitle: "Subtitle", titleFont: .callout, titleColour: .orange, subtitleFont: .caption, subtitleColour: .blue), chartStyle: LineChartStyle(infoBoxPlacement: .infoBox(isStatic: false), infoBoxBorderColour: .primary, infoBoxBorderStyle: StrokeStyle(lineWidth: 1), markerType: .vertical(attachment: .line(dot: .style(DotStyle()))), xAxisGridStyle: GridStyle(numberOfLines: 7, lineColour: Color(.lightGray).opacity(0.5), lineWidth: 1, dash: [8], dashPhase: 0), xAxisLabelPosition: .bottom, xAxisLabelColour: .primary, xAxisLabelsFrom: .dataPoint(rotation: .degrees(0)), yAxisGridStyle: GridStyle(numberOfLines: 7, lineColour: Color(.lightGray).opacity(0.5), lineWidth: 1, dash: [8], dashPhase: 0), yAxisLabelPosition: .leading, yAxisNumberOfLabels: 7, baseline: .minimumWithMaximum(of: baseline), topLine: .maximum(of: topline), globalAnimation: .easeInOut(duration: 1)))
                }
            } catch let err {
                print(err)
            }
        }
        
        task.resume()
        
                
    }
    
    func setTimeZoneRange(range: TimezoneRanges) {
        self.selectedTimeRange = range
    }
    
    // 2. API link needs the name of the coin. As well as the time range, but I'll deal with that later.
    func setCoinToShowDetails(coin: Coin) {
        self.coinToShowDetails = coin
    }
    
    func weekOfData() -> LineChartData {
            
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
    
    func toggleShowGraph() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showGraph.toggle()
        }
    }
    
    func resetLineChartData() {
        self.lineChartData = LineChartData(dataSets: LineDataSet(dataPoints: [LineChartDataPoint(value: 0, xAxisLabel: "", description: "")], legendTitle: "LegendTitle", pointStyle: PointStyle(), style: LineStyle(lineColour: ColourStyle(colour: .green), lineType: .curvedLine)), metadata: ChartMetadata(title: "Title", subtitle: "Subtitle", titleFont: .callout, titleColour: .orange, subtitleFont: .caption, subtitleColour: .blue), chartStyle: LineChartStyle(infoBoxPlacement: .infoBox(isStatic: false), infoBoxBorderColour: .primary, infoBoxBorderStyle: StrokeStyle(lineWidth: 1), markerType: .vertical(attachment: .line(dot: .style(DotStyle()))), xAxisGridStyle: GridStyle(numberOfLines: 7, lineColour: Color(.lightGray).opacity(0.5), lineWidth: 1, dash: [8], dashPhase: 0), xAxisLabelPosition: .bottom, xAxisLabelColour: .primary, xAxisLabelsFrom: .dataPoint(rotation: .degrees(0)), yAxisGridStyle: GridStyle(numberOfLines: 7, lineColour: Color(.lightGray).opacity(0.5), lineWidth: 1, dash: [8], dashPhase: 0), yAxisLabelPosition: .leading, yAxisNumberOfLabels: 7, baseline: .minimumWithMaximum(of: 0), topLine: .maximum(of: 15), globalAnimation: .easeInOut(duration: 1)))
    }
}
