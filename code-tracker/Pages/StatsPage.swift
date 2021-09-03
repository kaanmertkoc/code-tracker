//
//  StatsPage.swift
//  code-tracker
//
//  Created by Kaan Koç on 2.09.2021.
//

import SwiftUI

struct StatsPage: View {
    let weeklyCommits: [WeeklyCommit]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                DaysCard(weeklyCommits: weeklyCommits)
            }
        }.hideNavigationBar()
    }
}
