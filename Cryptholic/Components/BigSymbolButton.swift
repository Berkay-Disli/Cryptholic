//
//  BigSymbolButton.swift
//  Cryptholic
//
//  Created by Berkay Disli on 8.08.2022.
//

import SwiftUI

struct BigSymbolButton: View {
    let title: String
    let bgColor: Color
    let textColor: Color
    let image: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image("google")
                .resizable()
                .scaledToFit()
                .frame(width: 35)
                
            Text(title)
        }
        .font(.title3).fontWeight(.medium)
        .foregroundColor(textColor)
        .frame(maxWidth: .infinity).frame(height: 60)
        .background(bgColor.clipShape(Capsule().stroke()).shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5))
        
    }
}

struct BigSymbolButton_Previews: PreviewProvider {
    static var previews: some View {
        BigSymbolButton(title: "Sign In With Google", bgColor: .gray.opacity(0.1), textColor: .black, image: "google")
            .padding(.horizontal)
    }
}
