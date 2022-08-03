//
//  CoinsViewModel.swift
//  Cryptholic
//
//  Created by Berkay Disli on 3.08.2022.
//

import Foundation

class CoinsViewModel: ObservableObject {
    @Published var coins = Coins(coins: [Coin]())
    
    init() {
        getData()
    }
    
    func getData() {
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
}
