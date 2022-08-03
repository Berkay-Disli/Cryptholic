//
//  CoinsPage.swift
//  Cryptholic
//
//  Created by Berkay Disli on 3.08.2022.
//

import SwiftUI

struct CoinsPage: View {
    @ObservedObject var coinsVM: CoinsViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(coinsVM.coins.coins, id:\.self) { item in
                    HStack {
                        Text(item.name)
                        Text(String(item.rank)).bold()
                    }
                }
                
            }
        }
    }
}

struct CoinsPage_Previews: PreviewProvider {
    static var previews: some View {
        CoinsPage(coinsVM: CoinsViewModel())
    }
}
