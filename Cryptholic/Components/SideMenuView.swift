//
//  SideMenuView.swift
//  Cryptholic
//
//  Created by Berkay Disli on 21.08.2022.
//

import SwiftUI

struct SideMenuView: View {
    @ObservedObject var navVM: NavigationViewModel
    var body: some View {
        VStack {
            
            Button {
                withAnimation(.easeInOut) {
                    navVM.closeSideMenu()
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.title3)
            }

            Text("Deneme")
            Text("Berkay Dişli")
            
            
            
            Text("Berkay Dişli again..")
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
        SideMenuView(navVM: NavigationViewModel())
    }
}
