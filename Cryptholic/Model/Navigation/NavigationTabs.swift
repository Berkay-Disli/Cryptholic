//
//  NavigationTabs.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import Foundation

enum Tabs: String, CaseIterable {
    case home, coins, profile
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .coins:
            return "Coins"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .coins:
            return "bitcoinsign.circle"
        case .profile:
            return "person"
        }
    }
}
