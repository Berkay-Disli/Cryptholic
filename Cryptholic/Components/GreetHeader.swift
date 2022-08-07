//
//  GreetHeader.swift
//  Cryptholic
//
//  Created by Berkay Disli on 7.08.2022.
//

import SwiftUI

struct GreetHeader: View {
    let title1: String
    let title2: String
    let secondColor: Color
    var body: some View {
        VStack(alignment: .leading){
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.medium)
            Text(title2)
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(secondColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.horizontal])
    }
}

struct GreetHeader_Previews: PreviewProvider {
    static var previews: some View {
        GreetHeader(title1: "Hello!", title2: "Welcome Back", secondColor: .red)
    }
}
