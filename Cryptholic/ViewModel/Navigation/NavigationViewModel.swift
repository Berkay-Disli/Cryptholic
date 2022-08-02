//
//  NavigationViewModel.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import Foundation

class NavigationViewModel: ObservableObject {
    
    @Published var showTabBar = true
    @Published var tabSelection: Tabs = .home
    
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
}
