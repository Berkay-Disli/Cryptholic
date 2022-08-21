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
            VStack(alignment: .leading, spacing: 4) {
                if let user = authVM.userSession {
                    Text(user.displayName ?? "No Name")
                        .font(.title)
                        .fontWeight(.medium)
                    Text(verbatim: user.email ?? "No Email")
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            Divider().background(.black.opacity(0.4))
                .padding(.bottom)
            
            // Options
            VStack(alignment: .leading, spacing: 20) {
                ForEach(SideMenuOptions.allCases, id:\.self) { item in
                    NavigationLink {
                        item.destination
                    } label: {
                        SideMenuOptionItems(icon: item.icon, title: item.title)
                    }

                }
            }
            
            Spacer()
            
            Text("Created by Berkay Dişli")
                .font(.footnote)
                .fontWeight(.medium)
                .padding(.bottom, 40)
        }
        .frame(width: UIScreen.main.bounds.width * 0.65, height: UIScreen.main.bounds.height)
        .background(.white)
        .offset(x: navVM.sideMenuActive ? -UIScreen.main.bounds.width * 0.175:-UIScreen.main.bounds.width * 0.825, y: 0)
        .transition(AnyTransition.move(edge: .leading).animation(.easeInOut))
        .edgesIgnoringSafeArea(.horizontal)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(navVM: NavigationViewModel(), authVM: AuthenticationViewModel())
    }
}



