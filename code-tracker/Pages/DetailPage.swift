//
//  DetailPage.swift
//  code-tracker
//
//  Created by Kaan Koç on 5.09.2021.
//

import SwiftUI

struct DetailPage: View {
    
    @EnvironmentObject var network: Network
    let repo : Repo
    
    let weeklyCommit = [[1625961600, 52304, 0],[1626566400,1859,-822], [1627171200,1728,-229], [1627776000, 1003, -495], [1628380800,3595,-1887],[1628985600,1749,-810],[1629590400,1204,-818],[1630195200,604,-421],[1630800000,0,0]]
    
    func getTotalLines() -> Int {
        var count = 0
        for commit in network.commits {
                count += commit[1] + abs(commit[2])
        }
        return count
    }
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                if network.commits.capacity > 1 {
                    HeaderCard(repo: repo)
                        .padding(.init(.init(top: 80, leading: 0, bottom: 0, trailing: 0)))
                    CommitList(weeklyCommit: network.commits)
                        .frame(width: screenWidth, height: screenHeight / 1.8)
                    Spacer()
                    HStack {
                        Text("Lines Total: ")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color.white)
                        Text("\(getTotalLines())")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(Color.white)
                    }
                }
                Spacer()
                
            }
            .onAppear() {
                network.getCommitDetails(repoName: repo.full_name)
            }
        }.ignoresSafeArea()
    }
}


struct CommitList: View {
    
    let weeklyCommit: [[Int]]
        
    var body: some View {
        VStack {
            Text("Commits")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.white)
                .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            ScrollView {
                ForEach(weeklyCommit, id:\.self) { commit in
                    CommitCard(weeklyCommit: commit)

                }
            }
        }
    }
}
struct HeaderCard: View {
    
    let repo: Repo
    @State var commitCount = 0
    let oneCommitColor = Color(red: 13/255, green: 68/255, blue: 41/255)
    let threeCommitColor = Color(red: 1/255, green: 109/255, blue: 49/255)
    let sixCommitColor = Color(red: 38/255, green: 166/255, blue: 65/255)
    let nineCommitColor = Color(red: 57/255, green: 211/255, blue: 83/255)
    
    func getCommits() -> Int {
        var count = 0
        for commits in repo.commitsPerWeek {
            count += commits
        }
        return count
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image("\(repo.language)-plain")
                .resizable()
                .frame(width: 100, height: 100)
            VStack {
                Text("\(repo.full_name)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.white)
                    .padding(.init(top: 0, leading: 0, bottom: 20, trailing: 0))
                HStack {
                    Text("Total Commits: ")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.white)
                        .frame(width: 150, height: 30)
                    Text("\(commitCount)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(
                            commitCount == 0 ? Color.white : commitCount > 0 ? oneCommitColor : commitCount > 10 ? threeCommitColor : commitCount > 50 ? sixCommitColor : commitCount > 100 ? nineCommitColor : Color.white)
                        .frame(width: 40, height: 50)
                }
            }
            .padding()
            .onAppear() {
                commitCount = getCommits()
            }
        }.frame(width: screenWidth, height: 150, alignment: .top)
    }
}

struct CommitCard: View {
    
    let weeklyCommit: [Int]

    var body: some View {
        
            HStack {
                Circle()
                    .stroke(Color(red: 33/255, green: 170/255, blue: 141/255))
                    .frame(width: 20, height: 20)
                Text("\(weeklyCommit[1])")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.white)
                    .frame(width: 75)
                Text("additions")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.green)
                    .frame(width: 100)

                Text("\(weeklyCommit[2])")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.white)
                    .frame(width: 75)

                Text("deletions")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color.red)
                    .frame(width: 100)

            }
            .frame(width: screenWidth)
        Spacer()
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(repo: Repo(id: 1, full_name: "lezada-commerce", language: "JavaScript", commitsPerWeek: [0, 1, 2]))
            .environmentObject(Network())
    }
}
