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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                
                switch navVM.tabSelection {
                case .home:
                    Home(coinsVM: coinsVM)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                case .coins:
                    CoinsPage(coinsVM: coinsVM)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                case .profile:
                    Profile(coinsVM: coinsVM)
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
                                .foregroundColor(navVM.tabSelection == tabItem ? Color("black"):colorScheme == .dark ? Color(uiColor: .lightGray):.gray)
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
                
                Rectangle().fill(.black.opacity(navVM.sideMenuActive ? 0.2:0))
                            .ignoresSafeArea()
                            .onTapGesture {
                                if navVM.sideMenuActive {
                                    withAnimation(.easeInOut) {
                                        navVM.closeSideMenu()
                                        //navVM.showTabBar()
                                            }
                                        }
                                    }
                            .zIndex(1)
                
                
                if navVM.sideMenuActive {
                    SideMenuView(navVM: navVM, authVM: authVM, coinsVM: coinsVM)
                    .zIndex(2)
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                authVM.getUserInfo { success in
                    if success {
                        setFilteredArray()
                    }
                }
                navVM.tabSelection = .home
            }
            .toolbar(.hidden)
            .onDisappear {
                authVM.firebaseSignUpUsed = false
            }
        }
    }
    
    
    
    func setFilteredArray() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            var filteredArray = [Coin]()
            for coinId in authVM.favouriteCoins {
                let result = coinsVM.coins.coins.filter { $0.id == coinId }
                guard let firstItem = result.first else {
                    print("ERROR: TabManager->onAppear")
                    return
                }
                filteredArray.append(firstItem)
            }
            self.authVM.filtered = filteredArray
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
