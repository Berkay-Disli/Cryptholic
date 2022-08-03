//
//  CoinListCell.swift
//  Cryptholic
//
//  Created by Berkay Disli on 3.08.2022.
//

import SwiftUI

struct CoinListCell: View {
    let showGraph: Bool
    let image: String
    let name: String
    let symbol: String
    let price: Double
    let dailyChange: Double
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(.orange)
                .font(.system(size: 45))
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .fontWeight(.medium)
                Text(symbol)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if showGraph {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 35))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("USD \(price.formatted())")
                Text("\(dailyChange.formatted())%")
                    .foregroundColor(dailyChange >= 0 ? .green:.red)
            }
            
        }
        .padding(.bottom,8)
    }
}

struct CoinListCell_Previews: PreviewProvider {
    static var previews: some View {
        CoinListCell(showGraph: false, image: "bitcoinsign.circle.fill", name: "Bitcoin", symbol: "BTC", price: 40981.51, dailyChange: 15.26)
    }
}
