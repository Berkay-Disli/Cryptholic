//
//  IconButton.swift
//  Cryptholic
//
//  Created by Berkay Disli on 4.08.2022.
//

import SwiftUI

struct IconButton: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.system(size: 18))
            .foregroundColor(.black)
            .frame(width: 50, height: 50)
            .background(Color(uiColor: .systemGray6))
            .clipShape(Circle())
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(iconName: "star")
    }
}
