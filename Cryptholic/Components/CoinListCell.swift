//
//  CoinListCell.swift
//  Cryptholic
//
//  Created by Berkay Disli on 3.08.2022.
//

import SwiftUI
import Kingfisher

struct CoinListCell: View {
    let showGraph: Bool
    let image: String
    let name: String
    let symbol: String
    let price: Double
    let dailyChange: Double
    
    var body: some View {
        HStack {
            KFImage(URL(string: image))
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 45)
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .fontWeight(.medium)
                Text(symbol)
                    .foregroundColor(.gray)
            }
            .foregroundColor(.black)
            
            Spacer()
            
            if showGraph {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 35))
                    
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("USD \(price.formatted())")
                    .lineLimit(1)
                HStack(spacing: 4) {
                    Image(systemName: dailyChange >= 0 ? "arrow.up.right": "arrow.down.right")
                        .font(.footnote)
                    Text("\(dailyChange.formatted())%")
                }
                .foregroundColor(dailyChange >= 0 ? .green:.red)
            }
            .foregroundColor(.black)
            
        }
        .padding(.bottom,8)
    }
}

struct CoinListCell_Previews: PreviewProvider {
    static var previews: some View {
        CoinListCell(showGraph: true, image: "https://static.coinstats.app/coins/1650455588819.png", name: "Bitcoin", symbol: "BTC", price: 40981.51, dailyChange: 15.26)
    }
}
