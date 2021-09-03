//
//  DaysCard.swift
//  code-tracker
//
//  Created by Kaan Koç on 3.09.2021.
//

import SwiftUI

struct DaysCard: View {
    
    let weeklyCommits : [WeeklyCommit]
    
    func getSumOfCommitsPerDay() -> [Int] {
        var commitsPerDay : [Int] = [0, 0, 0, 0, 0, 0, 0]
        for commit in weeklyCommits {
            for i in 0..<commit.days.capacity - 1 {
                print(i)
                commitsPerDay[i] += commit.days[i]
            }
        }
        return commitsPerDay
    }
        
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text("Days In A Row")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color.white)
                    .padding()
                HStack {
                    ForEach(getSumOfCommitsPerDay(), id: \.self) { commitDay in
                        DaysCircle(number: commitDay)
                    }
                }
                Spacer()
            }.frame(width: 330, height: 150)
            
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(Color.gray)
                .frame(width: 330, height: 150)
                .foregroundColor(Color.black.opacity(0))
        }
    }
}

struct DaysCircle: View {
    let number: Int
    let oneCommitColor = Color(red: 13/255, green: 68/255, blue: 41/255)
    let threeCommitColor = Color(red: 1/255, green: 109/255, blue: 49/255)
    let sixCommitColor = Color(red: 38/255, green: 166/255, blue: 65/255)
    let nineCommitColor = Color(red: 57/255, green: 211/255, blue: 83/255)
    
    var body: some View{
        ZStack {
            
            ZStack {
                Circle()
                    .strokeBorder(Color.gray)
                Circle()
                    .fill((number == 1 ? oneCommitColor : number > 1 ? threeCommitColor : number > 3 ? sixCommitColor : number > 6 ? nineCommitColor : Color.black.opacity(0)))
                
            }.frame(width: 30, height: 30)
            
            Text(String(describing: number))
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color.white)
        
        }.frame(width: 30, height: 30)
    }
    
}

struct DaysCard_Previews: PreviewProvider {
    
    static var previews: some View {
        DaysCard(weeklyCommits: [WeeklyCommit(total: 4, week: 1, days: [1, 2, 3, 4, 0, 0]), WeeklyCommit(total: 7, week: 2, days: [3, 2, 2, 2, 1] )])
        
    }
}
