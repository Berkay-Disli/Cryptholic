//
//  CoinPrices.swift
//  Cryptholic
//
//  Created by Berkay Disli on 5.08.2022.
//

//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct CoinPrices: Codable {
    let chart: [[Double]]
}
