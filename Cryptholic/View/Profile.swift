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
    @State private var notificationsEnabled = true
    
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
                            
                            Text(verbatim: "berkay.dsli@gmail.com")
                                .foregroundColor(.gray)
                            Text("Berkay Dişli")
                                .font(.largeTitle)
                                .fontWeight(.medium)
                        }
                        Spacer()
                        Image("logoFinal")
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
                        
                        // Favourites, only first 3 item.
                        ForEach(1...3, id:\.self) { item in
                            CoinListCell(showGraph: false, image: "https://static.coinstats.app/coins/1650455588819.png", name: "Bitcoin", symbol: "BTC", price: 40981.51, dailyChange: 15.26)
                                .padding(.bottom, 14)
                        }
                        
                        Button {
                            // navigate to favourites
                        } label: {
                            BigButton(title: "See All", bgColor: Color(uiColor: .systemGray5), textColor: .black)
                        }

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .bottom])
                    
                    Divider()
                    
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
                        .foregroundColor(.black)
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
                            .foregroundColor(.black)
                            .frame(height: 60)
                        }
                        
                        //Country
                        HStack {
                            Text("Country")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.black)
                        .frame(height: 60)
                        
                        // Privacy
                        HStack {
                            Text("Privacy")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.black)
                        .frame(height: 60)
                        
                        // Notification
                        Menu {
                            Toggle("Enabled", isOn: $notificationsEnabled)
                        } label: {
                            HStack {
                                Text("Notification Settings")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                        .foregroundColor(.black)
                        .frame(height: 60)
                        
                        BigButton(title: "Sign Out", bgColor: Color(uiColor: .systemGray5), textColor: .red)
                            .padding(.bottom, 75)
                        
                        
                        
                        
                        

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()


                    Spacer()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
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
            Profile()
                .environmentObject(AuthenticationViewModel())

    }
}
