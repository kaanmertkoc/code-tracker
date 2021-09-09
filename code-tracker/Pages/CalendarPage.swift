//
//  CalendarPage.swift
//  code-tracker
//
//  Created by Kaan Koç on 8.09.2021.
//

import SwiftUI
import ElegantCalendar

struct CalendarPage: View {
    
    @EnvironmentObject var network: Network
    let repos: [Repo]
    let oneCommitColor = Color(red: 13/255, green: 68/255, blue: 41/255)
    let threeCommitColor = Color(red: 1/255, green: 109/255, blue: 49/255)
    let sixCommitColor = Color(red: 38/255, green: 166/255, blue: 65/255)
    let nineCommitColor = Color(red: 57/255, green: 211/255, blue: 83/255)
    
    func getVisits(weeklyCommits: [[WeeklyCommit]]) -> [Visit] {
        
        var visits: [Visit] = []
        var weeklyCommitsSum : [WeeklyCommit] = [WeeklyCommit] (repeating: WeeklyCommit(total: 0, week: 0, days: [Int] (repeating: 0, count: 7)), count: 52)
        
        
        for commitsArr in weeklyCommits {
            if commitsArr[0].week != 0 {
                
                for i in 0..<commitsArr.count {
                    
                    //let sum  = commitsArr[i].days.reduce(0, +)
                    weeklyCommitsSum[i].week = commitsArr[i].week
                    for j in 0..<commitsArr[i].days.count {
                        weeklyCommitsSum[i].days[j] += commitsArr[i].days[j]
                    }
                }
            }
           
        }
        
        for week in weeklyCommitsSum {
            let unixTimestamp = week.week
            let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
            
            for i in 0..<week.days.count {
                
                let day = week.days[i]
                
                let color = day == 0 ? Color.black : day > 0 ? oneCommitColor : day > 2 ? threeCommitColor : day > 5 ? sixCommitColor : day > 8 ? nineCommitColor : Color.black
                
                var dayComponent = DateComponents()
                dayComponent.day = i
                let dateOfDay = Calendar.current.date(byAdding: dayComponent, to: date)
                
                let visit = Visit(locationName: "\(day) commit", tagColor: color, arrivalDate: dateOfDay!, departureDate: dateOfDay!)
                visits.append(visit)
            }
        }
        return visits
    }
   
        var body: some View {
            
            VStack {
                if network.weeklyCommits.count >= repos.count {
                    ExampleMonthlyCalendarView(
                        ascVisits: getVisits(weeklyCommits: network.weeklyCommits),
                        initialMonth: .daysFromToday(0))
                }
                else {
                    ProgressView("Loading")
                }
            }
            .onAppear() {
                for repo in repos {
                    network.getWeeklyCommits(repoName: repo.full_name)
                }
            }
        }
        
}


struct CalendarPage_Previews: PreviewProvider {
    
    static var previews: some View {
        CalendarPage(repos: [])
    }
}
