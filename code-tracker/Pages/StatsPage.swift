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
    let languages: [Languages]
    @EnvironmentObject var network: Network
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    @State var isDone: Bool = false
    
    
    func getTotalLines() -> Int {
        
        for repo in repos {
            network.getCommitDetails(repoName: repo.full_name)
            print(network.commits)
        }
        return 1
    }
    func transformDataToTuples(languages: [Languages]) -> [(String, Double)] {
        
        let sum = languages.map({$0.value}).reduce(0, +)
        
        var stuff:[(String, Double)] = []
        
        for language in languages {
            stuff.append((language.language, (Double(language.value) * 100.0) / Double(sum)))
        }
        return stuff
    }
    
    func getCommitsperWeek(repos: [Repo]) -> [Double] {
        var commits : [Double] = [Double](repeating: 0, count: 52)
        
        for repo in repos {
            for i in 0..<repo.commitsPerWeek.count {
                commits[i] += Double(repo.commitsPerWeek[i])
            }
        }
        
        return commits
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    
                    TotalLinesCard(line: network.totalLines)
                        .padding()
                    
                        BarChartView(
                            data: ChartData(values: transformDataToTuples(languages: languages)), title: "Top Languages Used By Percent", legend: "Language", style: Styles.barChartMidnightGreenLight, form: ChartForm.extraLarge)
                      
                        LineView(data: getCommitsperWeek(repos: repos), title: "Commits In A Year Per Week", legend: "Commits")
                            .frame(width: screenWidth - 20, height: 350)
                            .padding()
                    
                }
                .onAppear() {
                    network.getTotalLines(repos: repos)
                }
            }
            .ignoresSafeArea()
            .padding()
        }.hideNavigationBar()
    }
}

struct TotalLinesCard: View {
    
    let line: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .cornerRadius(20)
                .shadow(color: Color.gray, radius: 8)
            VStack {
                Text("Total Lines Of Code Written")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color.white)
                    .padding()
                    .padding(.top, 5)
                Spacer()
                Text("\(line)")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color.white)
                
                Spacer()
            }
        }
        .frame(width: ChartForm.large.width, height: ChartForm.large.height)
    }
}


struct Demo: View {
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]

    var body: some View {
        ScrollView {
            VStack {
                BarChartView(
                    data: ChartData(points: demoData), title: "Top Languages Used By Percent", legend: "Language", style: Styles.barChartMidnightGreenLight, form: ChartForm.extraLarge)
                    .padding()
              
                
                
                TotalLinesCard(line: 101002)
                    .padding()
                LineView(data: demoData, title: "Commits In A Year Per Week", legend: "Commits")
                    .frame(width: screenWidth - 20, height: 350)
                    .padding()
            }
        }
    }
}

struct StatsPage_Preview: PreviewProvider {
    static var previews: some View {
        Demo()
    }
}
