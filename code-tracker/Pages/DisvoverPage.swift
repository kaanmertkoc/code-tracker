//
//  DisvoverPage.swift
//  code-tracker
//
//  Created by Kaan Koç on 29.05.2022.
//

import SwiftUI
struct DiscoverPage: View {
    let languages: [Languages]
    @EnvironmentObject var network: Network

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    
                    
                    
                }
                .onAppear() {
                    network.getQuery(languages: languages)
                }
            }
        }
        .ignoresSafeArea()
        .hideNavigationBar()
    }
}
