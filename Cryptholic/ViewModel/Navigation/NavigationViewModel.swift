//
//  NavigationViewModel.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import Foundation
import SwiftUI

class NavigationViewModel: ObservableObject {
    
    @Published var showTabBar = true
    @Published var tabSelection: Tabs = .home
    @Published var sideMenuActive = false
    @Published var onboarding = true
    @Published var darkModeEnabled = false
    
    init() {
        
    }
    
    // This function will be called when the user touches the desired icon on the tab bar
    func setTab(tab: Tabs) {
        tabSelection = tab
    }
    
    // These two functions are for making the tab bar visible/invisible
    func openTabBar() {
        showTabBar = true
    }
    func closeTabBar() {
        showTabBar = false
    }
    
    func openSideMenu() {
        self.sideMenuActive = true
    }
    
    func closeSideMenu() {
        self.sideMenuActive = false
    }
    
    func disableOnboarding() {
        onboarding = false
    }
    func enableOnboarding() {
        onboarding = true
    }
    func goToProfileView() {
        tabSelection = .profile
    }
}
