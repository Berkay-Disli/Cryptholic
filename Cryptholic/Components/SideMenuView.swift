//
//  SideMenuView.swift
//  Cryptholic
//
//  Created by Berkay Disli on 21.08.2022.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SideMenuView: View {
    @ObservedObject var navVM: NavigationViewModel
    @ObservedObject var authVM: AuthenticationViewModel
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.easeInOut) {
                    navVM.closeSideMenu()
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.black)
                    .rotationEffect(Angle(degrees: navVM.sideMenuActive ? 0:180))
                    .animation(.easeInOut, value: navVM.sideMenuActive)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            .padding(.top, 38)
            
            // User
            VStack(alignment: .center, spacing: 4) {
                if let user = authVM.userSession {
                    Image("logoFinal")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .padding(.bottom, 4)
                        .offset(x: -8)
                    Text(user.displayName ?? "No Name")
                        .font(.title)
                        .fontWeight(.medium)
                }
                /*Image("logoFinal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .padding(.bottom, 4)
                    .offset(x: -8)
                Text("Berkay Dişli")
                    .font(.title)
                    .fontWeight(.medium)*/
            }
            .frame(maxWidth: .infinity)
            .padding(.leading)
            
            NavigationLink {
                Profile()
            } label: {
                SideMenuBigButton(bgColor: Color(uiColor: .systemGray5), text: "Profile")
            }
            .padding(.bottom, 20)

            
            // Options
            VStack(alignment: .leading, spacing: 22) {
                ForEach(SideMenuOptions.allCases, id:\.self) { item in
                    NavigationLink {
                        item.destination
                    } label: {
                        SideMenuOptionItems(icon: item.icon, title: item.title)
                    }

                }
            }
            
            Spacer()
            
            Button {
                authVM.signOut()
            } label: {
                SideMenuBigButton(bgColor: Color(uiColor: .systemGray5), text: "Sign Out")
            }
            .padding(.bottom, 45)
        }
        .frame(width: UIScreen.main.bounds.width * 0.65, height: UIScreen.main.bounds.height)
        .background(Color.white.shadow(color: .gray.opacity(0.2), radius: 5, x: 5, y: 0))
        .offset(x: navVM.sideMenuActive ? -UIScreen.main.bounds.width * 0.175:-UIScreen.main.bounds.width * 0.825, y: 0)
        .transition(AnyTransition.move(edge: .leading).animation(.easeInOut))
        .ignoresSafeArea()
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(navVM: NavigationViewModel(), authVM: AuthenticationViewModel())
    }
}



