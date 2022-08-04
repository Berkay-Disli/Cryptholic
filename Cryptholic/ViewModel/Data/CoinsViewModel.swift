//
//  CoinsViewModel.swift
//  Cryptholic
//
//  Created by Berkay Disli on 3.08.2022.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coins = Coins(coins: [Coin]())
    // Created an empty Coin object to start with
    var coinToShowDetails = Coin(id: "", icon: "", name: "", symbol: "", rank: 0, price: 0, priceBtc: 0, volume: 0, marketCap: 0, availableSupply: 0, totalSupply: 0, priceChange1h: 0, priceChange1d: 0, priceChange1w: 0, websiteURL: "", twitterURL: "", exp: [""], contractAddress: "", decimals: 0, redditURL: "")
    
    init() {
        getData()
    }
    
    func getData() {
        coins = Coins(coins: [Coin]())
        guard let url = URL(string: "https://api.coinstats.app/public/v1/coins") else { return }
        print("DEBUG: Url is OK.")
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            print("DEBUG: Inside datatask.")
            guard let data, error == nil else { return }
            print("DEBUG: Data is OK.")
            do {
                let result = try JSONDecoder().decode(Coins.self, from: data)
                print("DEBUG: Result is decoded.")
                DispatchQueue.main.async {
                    self.coins = result
                    print("DEBUG: coins is changed.")
                }
            } catch let err {
                print(err)
            }
        }
        
        task.resume()
    }
    
    // 2. API link needs the name of the coin. As well as the time range, but I'll deal with that later.
    func setCoinToShowDetails(coin: Coin) {
        self.coinToShowDetails = coin
    }
}
