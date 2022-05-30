//
//  StarPage.swift
//  code-tracker
//
//  Created by Kaan Koç on 29.05.2022.
//

import SwiftUI
struct StarPage: View {
    @State private var isActive = false
    var repos : [StarredRepo]
    
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
               
                
                if repos.capacity > 0 {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        ForEach(repos, id: \.id) { repo in
                            StarPageCard(repoName: repo.full_name, stars: repo.stargazers_count, language: repo.language)
                            
                        }
                    }).padding(.init(top: 80, leading: 0, bottom: 0, trailing: 0))
                    .frame(width: screenWidth - 100, height: screenHeight)
                                            
                }
                else {
                    ProgressView("Loading")
                }
                Spacer()
            }
        }
        .ignoresSafeArea()
        .hideNavigationBar()
        
    }
}

