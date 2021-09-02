//
//  Home.swift
//  code-tracker
//
//  Created by Kaan Koç on 2.09.2021.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var network: Network

    
    var body: some View {
        TabView {
            HomePage()
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }.environmentObject(network)
            StatsPage()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                }
                .environmentObject(network)
        }.foregroundColor(Color.black)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
