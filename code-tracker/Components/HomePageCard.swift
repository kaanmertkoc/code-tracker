//
//  HomePageCard.swift
//  code-tracker
//
//  Created by Kaan Koç on 1.09.2021.
//

import SwiftUI

struct Commit {
    var additions: Int
    var deletions: Int
    
}

struct HomePageCard: View {
    
    let repoName: String
    let commits: [[Int]]
    let language: String
    
    func getCommits() -> [String] {
        var commitsArray = [""]
        if commits.capacity > 3 {
            for i in 0..<3 {
                if commits[i].capacity > 3 {
                    commitsArray.append("Addition \(commits[i][1]), deletion \(commits[i][2]) with sum of \(commits[i][1] + abs(commits[i][2]))")
                }
            }
        }
        return commitsArray
    }
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                Text(repoName)
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(Color.white)
                    .padding()
                
                HStack {
                    VStack {
                        Image("\(language)-plain")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Language of the repo")
                            .font(.system(size: 8, weight: .light))
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    Spacer()
                    VStack {
                        Text("Last 3 commits")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color.white)
                        ForEach(getCommits(), id: \.self) { commit in
                                Text(commit)
                                    .font(.system(size: 10))
                                    .foregroundColor(Color.white)
                        }
                    }
                    Spacer()
                }
                
                Spacer()
            }
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray)
                .frame(width: 330, height: 200)
                .foregroundColor(Color.black.opacity(0))
            
        }.frame(width: 330, height: 200)
    }
}

struct HomePageCard_Previews: PreviewProvider {
    static var previews: some View {
        HomePageCard(repoName: "lezada-commerce", commits: [ [1618099200, 21242, -300], [1618704000, 26066, -330], [1619308800, 2050, -3405]], language: "JavaScript")
    }
}
