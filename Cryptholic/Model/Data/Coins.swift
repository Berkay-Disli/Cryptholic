//
//  Coins.swift
//  Cryptholic
//
//  Created by Berkay Disli on 3.08.2022.
//

import Foundation

// MARK: - Welcome
struct Coins: Codable, Hashable{
    let coins: [Coin]
}

// MARK: - Coin
struct Coin: Codable, Hashable {
    let id: String
    let icon: String
    let name, symbol: String
    let rank: Int
    let price, priceBtc: Double
    let volume: Double?
    let marketCap, availableSupply, totalSupply, priceChange1H: Double?
    let priceChange1D, priceChange1W: Double?
    let websiteURL: String?
    let twitterURL: String?
    let exp: [String]
    let contractAddress: String?
    let decimals: Int?
    let redditURL: String?
}
