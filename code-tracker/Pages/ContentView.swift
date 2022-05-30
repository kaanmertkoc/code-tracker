//
//  ContentView.swift
//  code-tracker
//
//  Created by Kaan Koç on 29.08.2021.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.black
                    .ignoresSafeArea()
                
                    OpeningScreen()
                
            }
        }.navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
