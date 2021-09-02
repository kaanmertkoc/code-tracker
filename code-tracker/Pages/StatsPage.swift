//
//  StatsPage.swift
//  code-tracker
//
//  Created by Kaan Koç on 2.09.2021.
//

import SwiftUI

struct StatsPage: View {
    @EnvironmentObject var network: Network
    var body: some View {
        ZStack {
            
        }.hideNavigationBar()
    }
}

struct StatsPage_Previews: PreviewProvider {
    static var previews: some View {
        StatsPage()
            .environmentObject(Network())
    }
}
