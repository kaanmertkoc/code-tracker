//
//  HomePageCard.swift
//  code-tracker
//
//  Created by Kaan Koç on 1.09.2021.
//

import SwiftUI


struct HomePageCard: View {
    
    let repoName: String
    let commits: [Int]
    let language: String
    let oneCommitColor = Color(red: 13/255, green: 68/255, blue: 41/255)
    let threeCommitColor = Color(red: 1/255, green: 109/255, blue: 49/255)
    let sixCommitColor = Color(red: 38/255, green: 166/255, blue: 65/255)
    let nineCommitColor = Color(red: 57/255, green: 211/255, blue: 83/255)
    @State var commitCount = 0
    
    
    func getCommitsSum() -> Int {
        var count = 0
        for commit in commits {
            count += commit
        }
        return count
    }
    
    var body: some View {
        ZStack {
            Color.black
            
            Rectangle()
                .fill(Color.black)
                .cornerRadius(10)
                .shadow(color: Color.gray, radius: 8)
                .frame(width: screenWidth - 10, height: 130)

            
            VStack(alignment: .center) {
                Text(repoName)
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(Color.white)
                    .padding()
                
                HStack {
                    Spacer()
                    VStack {
                        Image("\(language)-plain")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .padding(.init(top: 0, leading: 0, bottom: 30, trailing: 0))
                    Spacer()
                    VStack {
                        Text("Total Commits")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("\(commitCount)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(
                                commitCount == 0 ? Color.white : commitCount > 0 ? oneCommitColor : commitCount > 10 ? threeCommitColor : commitCount > 50 ? sixCommitColor : commitCount > 100 ? nineCommitColor : Color.white)
                    }.padding(.init(top: 0, leading: 0, bottom: 40, trailing: 0))
                    Spacer()
                }
                .onAppear() {
                    
                    commitCount = getCommitsSum()
                }
                
            }
            
            
        }.frame(width: screenWidth, height: 130)
    }
}

struct HomePageCard_Previews: PreviewProvider {
    static var previews: some View {
        HomePageCard(repoName: "lezada-commerce", commits: [0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            0,
                                                            1,
                                                            10,
                                                            9,
                                                            7,
                                                            14,
                                                            21,
                                                            33,
                                                            6], language: "JavaScript")
    }
}
