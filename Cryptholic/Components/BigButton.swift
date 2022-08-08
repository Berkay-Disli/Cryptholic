//
//  BigButton.swift
//  Cryptholic
//
//  Created by Berkay Disli on 7.08.2022.
//

import SwiftUI

struct BigButton: View {
    let title: String
    let bgColor: Color
    let textColor: Color
    
    var body: some View {
        Text(title)
            .font(.title3).fontWeight(.medium)
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity).frame(height: 60)
            .background(bgColor)
            .cornerRadius(100)
    }
}

struct BigButton_Previews: PreviewProvider {
    static var previews: some View {
        BigButton(title: "Add to Watchlist", bgColor: .black, textColor: .white)
    }
}
