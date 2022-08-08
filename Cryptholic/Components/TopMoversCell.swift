//
//  TopMoversCell.swift
//  Cryptholic
//
//  Created by Berkay Disli on 3.08.2022.
//

import SwiftUI
import Kingfisher

struct TopMoversCell: View {
    let icon: String
    let name: String
    let symbol: String
    let price: Double
    let priceChange: Double
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                KFImage(URL(string: icon))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                Text(name)
                    .fontWeight(.medium)
                    .foregroundColor(Color("black"))
            }
            HStack {
                Text(symbol)
                    .bold()
                    .foregroundColor(Color("black"))
                Text("USD \(price.formatted())")
                    .lineLimit(1)
                    .foregroundColor(.gray)
            }
            .font(.footnote)
            
            HStack(spacing: 4) {
                Image(systemName: priceChange >= 0 ? "arrow.up.right": "arrow.down.right")
                    .font(.footnote)
                Text("\(priceChange.formatted())%")
            }
            .foregroundColor(priceChange >= 0 ? .green:.red)
            .font(.title)
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.3)))
    }
}

struct TopMoversCell_Previews: PreviewProvider {
    static var previews: some View {
        TopMoversCell(icon: "https://static.coinstats.app/coins/1650455588819.png", name: "Bitcoin", symbol: "BTC", price: 22056.31, priceChange: 28.56)
    }
}
