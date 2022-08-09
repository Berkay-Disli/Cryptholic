//
//  TabManager.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import SwiftUI

// SwiftUI provides it's own tab view system.
// Yet I find it beneficial to create a custom one to be able to customize it however I'd like.

struct TabManager: View {
    @StateObject var coinsVM = CoinsViewModel()
    @EnvironmentObject var navVM: NavigationViewModel
    @EnvironmentObject var authVM: AuthenticationViewModel

    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            switch navVM.tabSelection {
            case .home:
                Home(coinsVM: coinsVM)
                .transition(AnyTransition.opacity.animation(.easeInOut))
            case .coins:
                CoinsPage(coinsVM: coinsVM)
                .transition(AnyTransition.opacity.animation(.easeInOut))
            case .profile:
                Profile()
                .transition(AnyTransition.opacity.animation(.easeInOut))
            }
            
            if navVM.showTabBar {
                VStack(spacing: 0) {
                    Divider()
                    HStack {
                        ForEach(Tabs.allCases, id:\.self) { tabItem in
                            Spacer()
                            VStack(spacing: 4) {
                                Image(systemName: navVM.tabSelection == tabItem ? "\(tabItem.iconName).fill" :tabItem.iconName)
                                    .font(.system(size: 25))
                                Text(tabItem.title)
                                    .font(.callout)
                            }
                            .padding(.vertical, 4)
                            .foregroundColor(navVM.tabSelection == tabItem ? Color("black"):.gray)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    navVM.setTab(tab: tabItem)
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.top, 4)
                    .frame(height: 100, alignment: .top)
                    .background(Color("bg"))
                }
                .zIndex(1)
                .transition(AnyTransition.scale.combined(with: AnyTransition.opacity).animation(.easeInOut(duration: 0.25)))
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            authVM.getUserInfo { success in
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        var filteredArray = [Coin]()
                        for coinId in authVM.favouriteCoins {
                            let result = coinsVM.coins.coins.filter { $0.id == coinId }
                            filteredArray.append(result.first!)
                        }
                        self.authVM.filtered = filteredArray
                    }
                }
            }
            navVM.tabSelection = .home
        }
    }
}

struct TabManager_Previews: PreviewProvider {
    static var previews: some View {
        TabManager()
            .environmentObject(NavigationViewModel())
            .environmentObject(AuthenticationViewModel())
    }
}
