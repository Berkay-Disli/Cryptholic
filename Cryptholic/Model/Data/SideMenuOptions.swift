//
//  SideMenuOptions.swift
//  Cryptholic
//
//  Created by Berkay Disli on 21.08.2022.
//

import Foundation
import SwiftUI

enum SideMenuOptions: String, CaseIterable {
    case favourites, topics, news, professionals, settingsSecurity
    
    var icon: String {
        switch self {
        case .favourites:
            return "star"
        case .topics:
            return "message"
        case .news:
            return "newspaper"
        case .professionals:
            return "network"
        case .settingsSecurity:
            return "slider.vertical.3"
        }
    }
    
    var title: String {
        switch self {
        case .favourites:
            return "Favourites"
        case .topics:
            return "Topics"
        case .news:
            return "News"
        case .professionals:
            return "Cryptholic for Professionals"
        case .settingsSecurity:
            return "Settings"
        }
    }
    
    var destination: some View {
        switch self {
        case .favourites:
            return Profile(coinsVM: CoinsViewModel())
        case .topics:
            return Profile(coinsVM: CoinsViewModel())
        case .news:
            return Profile(coinsVM: CoinsViewModel())
        case .professionals:
            return Profile(coinsVM: CoinsViewModel())
        case .settingsSecurity:
            return Profile(coinsVM: CoinsViewModel())
        }
    }
}
