//
//  HomePage.swift
//  code-tracker
//
//  Created by Kaan Koç on 31.08.2021.
//

import SwiftUI

struct HomePage: View {
    @State private var isActive = false
    var repos : [Repo]
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                Header()
                    .padding(.init(top: 30, leading: 0, bottom: 0, trailing: 0))
                
                if repos.capacity > 0 {
                    ScrollView(.vertical, showsIndicators: false, content: {
                        ForEach(repos, id: \.id) { repo in
                            if repo.language != "none" {
                                NavigationLink(destination: DetailPage(repo: repo)) {
                                    HomePageCard(repoName: repo.full_name, commits: repo.commitsPerWeek, language: repo.language)
                                        .padding()
                                }                                    
                            }
                        }
                    }).padding()
                    .frame(width: screenWidth, height: screenHeight - 200)
                                            
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

struct Header : View {
    
    @State private var currentMonth = Date()
    
    func getCurrentMonthTitle() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        return dateFormatter.string(from: currentMonth)
        
    }
    
    var body: some View {
        HStack {
            NavButtons(image: "angle-left-solid 1", currentMonth: $currentMonth)
                .padding()
            Spacer()
            Text(getCurrentMonthTitle())
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.white)
            Spacer()
            NavButtons(image: "angle-right-solid 1", currentMonth: $currentMonth)
                .padding()
            
        }.onAppear() {
            
        }
    }
}

struct NavButtons: View {
    
    let image : String
    @Binding var currentMonth: Date
    let date = Date()
    let dateFormatter = DateFormatter()
    
    var body: some View {
        Button(action: {
            if(image == "angle-left-solid 1") {
                
                currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth)!
            }
            else if(image == "angle-right-solid 1") {
                dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
                let currMonthString = dateFormatter.string(for: currentMonth)!
                let compareMonthString = dateFormatter.string(for: date)!
                
                currentMonth = (currMonthString == compareMonthString ? currentMonth : Calendar.current.date(byAdding: .month, value: 1, to: currentMonth))!
            }
        }, label: {
            ZStack {
                
                Image(image)
                    .resizable()
                    .frame(width: 12, height: 24)
                Circle()
                    .stroke(Color.gray)
                    .frame(width: 30, height: 30)
            }
            
        })
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(repos: [Repo(id: 0, full_name: "kaan", language: "Python", commitsPerWeek: [0, 1, 1, 2]), Repo(id: 1, full_name: "cengo", language: "JavaScript", commitsPerWeek: [0, 1, 2, 42])])
    }
}

