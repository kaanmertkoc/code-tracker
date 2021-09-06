//
//  StatsPage.swift
//  code-tracker
//
//  Created by Kaan Koç on 2.09.2021.
//

import SwiftUI
import SwiftUICharts

struct StatsPage: View {
    let repos : [Repo]
    @EnvironmentObject var network: Network
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    
    func transformDataToTuples(languages: [Languages]) -> [(String, Double)] {
        
        var stuff:[(String, Double)] = []

        for language in languages {
            stuff.append((language.language, Double(language.value)))
        }
        return stuff
    }
 
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                if network.languages.capacity > 1 {
                    BarChartView(
                        data: ChartData(values: transformDataToTuples(languages: network.languages)), title: "Title", legend: "Legend", style: Styles.barChartMidnightGreenDark, form: ChartForm.extraLarge, dropShadow: true)
                        
                }
                else {
                    ProgressView("Loading")
                }
            }
            .onAppear() {
                for repo in repos {
                    network.getLanguagesPerRepo(repoName: repo.full_name)
                }
            }
        }.hideNavigationBar()
    }
}

