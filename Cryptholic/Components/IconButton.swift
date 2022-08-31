//
//  IconButton.swift
//  Cryptholic
//
//  Created by Berkay Disli on 4.08.2022.
//

import SwiftUI

struct IconButton: View {
    @Environment(\.colorScheme) var colorScheme
    let iconName: String
    let enabledIconName: String
    @Binding var notificationsEnabled: Bool
    
    var body: some View {
        Image(systemName: notificationsEnabled ? enabledIconName:iconName)
            .font(.system(size: 18))
            .foregroundColor(notificationsEnabled ? Color("white"):Color("black"))
            .frame(width: 50, height: 50)
            .background(colorScheme == .dark ? notificationsEnabled ? .white:Color(uiColor: .darkGray):notificationsEnabled ? .black:Color(uiColor: .systemGray6))
            .clipShape(Circle())
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(iconName: "bell", enabledIconName: "bell.fill", notificationsEnabled: .constant(true))
            .previewLayout(.sizeThatFits)
        IconButton(iconName: "bell", enabledIconName: "bell.fill", notificationsEnabled: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
