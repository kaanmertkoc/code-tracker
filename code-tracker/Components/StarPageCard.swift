//
//  HomePageCard.swift
//  code-tracker
//
//  Created by Kaan Koç on 29.05.2021.
//

import SwiftUI


struct StarPageCard: View {
    
    let repoName: String
    let stars: Int
    let language: String
    let starColor = Color(red: 253/255, green: 246/255, blue: 140/255)

    var body: some View {
        ZStack {
            Color.black
            
            Rectangle()
                .fill(Color.black)
                .cornerRadius(10)
                .shadow(color: Color.gray, radius: 8)
                .frame(width: screenWidth - 10, height: 130)

            
            VStack(alignment: .center) {
                HStack {
                Image(systemName: "star.fill")
                        .font(.system(size: 20))
                        .foregroundColor(starColor)
                        .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 0))
                Spacer()
                Text(repoName)
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(Color.white)
                    .padding()
                
                    Spacer()
                }
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
                        Text("Stars")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("\(stars)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(starColor)
                    }.padding(.init(top: 0, leading: 0, bottom: 40, trailing: 0))
                    Spacer()
                }
            }
        }.frame(width: screenWidth, height: 130)
            .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
    }
}
