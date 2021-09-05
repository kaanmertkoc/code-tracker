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
            if network.repos.capacity > 0 {
                HomePage(repos: network.repos)
                    .tabItem{
                        Label("Home", systemImage: "house.fill")
                    }
                /*
                StatsPage(weeklyCommits: network.weeklyCommits)
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar.xaxis")
                    }
                 */
                
            }
            else {
                ProgressView("Loading")
            }
            
            
        }.foregroundColor(Color.black)
        .onAppear() {
            network.getRepos()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
