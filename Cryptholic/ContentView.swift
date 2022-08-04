//
//  ContentView.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        VStack {
            Text("To Do's:").font(.title).bold()
            Text("Dark Mode \n All Coin Images need to be circled! \n")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NavigationViewModel())
    }
}
