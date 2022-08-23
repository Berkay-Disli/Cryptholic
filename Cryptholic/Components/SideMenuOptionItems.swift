//
//  SideMenuOptionItems.swift
//  Cryptholic
//
//  Created by Berkay Disli on 21.08.2022.
//

import SwiftUI

struct SideMenuOptionItems: View {
    let icon: String
    let title: String
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                
                Text(title)
            }
            .fontWeight(.medium)
            .foregroundColor(Color("black"))
            .padding(.leading)
            
            Divider()
        }
    }
}

struct SideMenuOptionItems_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionItems(icon: "star", title: "Favourites")
    }
}
