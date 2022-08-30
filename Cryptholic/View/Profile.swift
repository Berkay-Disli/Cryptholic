//
//  Profile.swift
//  Cryptholic
//
//  Created by Berkay Disli on 8.08.2022.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    @EnvironmentObject var navVM: NavigationViewModel
    @ObservedObject var coinsVM: CoinsViewModel
    @State private var notificationsEnabled = true
    @Environment(\.colorScheme) var colorScheme
    @State private var showSignOutAlert = false
    @State private var showAllFavs = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // MARK: User Info
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            if let user = authVM.userSession {
                                Text(verbatim: user.email ?? "No email found.")
                                    .foregroundColor(.gray)

                                Text(user.displayName ?? "Cryptholic User.")
                                    .font(.largeTitle)
                                    .fontWeight(.medium)
                            }
                            /*
                            Text(verbatim: "berkay.dsli@gmail.com")
                                .foregroundColor(.gray)
                            Text("Berkay Dişli")
                                .font(.largeTitle)
                                .fontWeight(.medium)
                            */
                        }
                        Spacer()
                        Image(colorScheme == .dark ? "logoFinalBlack":"logoFinal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 65, height: 65)
                    }
                    .frame(maxWidth: .infinity)
                    .padding([.horizontal, .top])
                    .padding(.bottom, 8)
                    
                    // MARK: Favourites
                    VStack(alignment: .leading) {
                        Text("Favourites")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.red)
                            .padding(.bottom, 8)
                        
                        // Favourites, only first 3 item.
                        if !authVM.filtered.isEmpty {
                            ScrollView {
                                if showAllFavs {
                                    ForEach(authVM.filtered, id:\.self) { coin in
                                        NavigationLink {
                                            CoinDetails(coinVM: coinsVM, coin: coin)
                                        } label: {
                                            CoinListCell(showGraph: false, image: coin.icon, name: coin.name, symbol: coin.symbol, price: coin.price, dailyChange: coin.priceChange1d ?? 0)
                                                .padding(.bottom, 14)
                                        }
                                    }
                                    .animation(.easeInOut, value: authVM.filtered)
                                    .transition(AnyTransition.opacity.animation(.easeInOut))
                                    
                                } else {
                                    ForEach(authVM.filtered.prefix(3), id:\.self) { coin in
                                        NavigationLink {
                                            CoinDetails(coinVM: coinsVM, coin: coin)
                                        } label: {
                                            CoinListCell(showGraph: false, image: coin.icon, name: coin.name, symbol: coin.symbol, price: coin.price, dailyChange: coin.priceChange1d ?? 0)
                                                .padding(.bottom, 14)
                                        }
                                    }
                                    .animation(.easeInOut, value: authVM.filtered)
                                    .transition(AnyTransition.opacity.animation(.easeInOut))
                                    
                                    if authVM.filtered.prefix(3).count != authVM.filtered.count {
                                        let itemsLeft = authVM.filtered.count - authVM.filtered.prefix(3).count
                                        Text("\(itemsLeft) more coins")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                            .padding(.top, -8)
                                    }
                                }
                                
                                Button {
                                    // remove prefix
                                    showAllFavs.toggle()
                                } label: {
                                    BigButton(title: showAllFavs ? "Shorten List":"See All", bgColor: Color("lightGray"), textColor: Color("black"))
                                        //.transition(AnyTransition.slide.animation(.easeInOut))
                                }
                            }
                        } else {
                            VStack(spacing: 4) {
                                Text("😶")
                                    .font(.system(size: 50))
                                Text("No Favourites.")
                                    .foregroundColor(Color("black"))
                                Text("Add coins to your list.")
                                    .foregroundColor(.red)
                            }
                            .font(.title3)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom)
                        }

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom])
                    
                    Divider()
                    
                    // This options menu will NOT be completely functional
                    // Therefore i've hardcoded all the items seperately
                    // But in reality, this is not the ideal way.
                    VStack(alignment: .leading) {
                        Text("Account")
                            .font(.title2)
                            .fontWeight(.medium)
                        // Features
                        HStack {
                            Text("New Features")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(Color("black"))
                        .frame(height: 60)
                        
                        // Native Currency
                        Menu {
                            Button {
                                
                            } label: {
                                Text("USD")
                            }
                            
                            Button {
                                
                            } label: {
                                Text("BTC")
                            }

                        } label: {
                            HStack {
                                Text("Native Currency")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(Color("black"))
                            .frame(height: 60)
                        }
                        
                        //Country
                        HStack {
                            Text("Country")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(Color("black"))
                        .frame(height: 60)
                        
                        // Privacy
                        HStack {
                            Text("Privacy")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(Color("black"))
                        .frame(height: 60)
                        
                        // System Theme
                        Toggle("Dark Mode", isOn: $navVM.darkModeEnabled)
                        
                        // Notification
                        Toggle("Notifications", isOn: $notificationsEnabled)
                        .foregroundColor(Color("black"))
                        .frame(height: 60)
                        
                        // Sign Out
                        Button {
                            showSignOutAlert.toggle()
                        } label: {
                            BigButton(title: "Sign Out", bgColor: Color("lightGray"), textColor: .red)
                                .padding(.bottom, 75)
                        }
                        .alert("Signing Out", isPresented: $showSignOutAlert) {
                            Button(role: .destructive) {
                                authVM.signOut()
                                navVM.enableOnboarding()
                            } label: {
                                Text("Sign Out")
                            }
                        } message: {
                            Text("Do you want to sign out?")
                        }
                        .alert(authVM.alertMessage, isPresented: $authVM.showAlert) {}

                        
                        

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()


                    Spacer()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
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
                navVM.openTabBar()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // open sidemenu --- ADD Drag Gesture
                        withAnimation(.easeInOut) {
                            navVM.openSideMenu()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(Color("black"))
                    }

                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "bell")
                }
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(coinsVM: CoinsViewModel())
                .environmentObject(AuthenticationViewModel())
                .environmentObject(NavigationViewModel())
    }
}
