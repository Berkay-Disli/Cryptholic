//
//  ContentView.swift
//  Cryptholic
//
//  Created by Berkay Disli on 2.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("To Do's:").font(.title).bold()
            Text("Graph's labels, legends and x y values")
            Text("TabView Icons.. Logo, Color palette")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NavigationViewModel())
    }
}
