//
//  SideMenuBigButton.swift
//  Cryptholic
//
//  Created by Berkay Disli on 22.08.2022.
//

import SwiftUI

struct SideMenuBigButton: View {
    let bgColor: Color
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(Color("black"))
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(bgColor)
            .cornerRadius(100)
            .padding(.horizontal)
    }
}

struct SideMenuBigButton_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuBigButton(bgColor: Color(uiColor: .systemGray5), text: "Profile")
    }
}
