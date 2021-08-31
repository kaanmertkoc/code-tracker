//
//  OpeningScreen.swift
//  code-tracker
//
//  Created by Kaan Koç on 29.08.2021.
//

import SwiftUI

let greenColor = Color(red: 33 / 255, green: 170 / 255, blue: 141 / 255)


struct OpeningScreen: View {
    
    var body: some View {
        VStack() {
            Image("openingScreenImage").resizable()
                .frame(width: screenWidth, height: screenWidth / 10 * 8, alignment: .top)
            
            Text("Code Tracker")
                .frame(width: screenWidth, height: 20, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .thin, design: .default))
                .padding(.init(top: 30, leading: 30, bottom: 0, trailing: 0))
            
            Text("Code tracker app, tracks your work via GitHub. Whenever you made a commit, it will detect and will count your lines of code that you write. Also it will detect which programming language you are written will weight the stats based on these.")
                .frame(width: screenWidth, height: 200, alignment: .leading)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium, design: .default))
                .padding(.init(top: 30, leading: 30, bottom: 0, trailing: 0))
            
            Spacer()
            NavigationLink(
                destination: SignUp()) {                
                    HStack {
                        Spacer()
                        Text("Next")
                            .foregroundColor(Color.white)
                        Spacer()
                        Button {
                            
                        } label: {
                            Image("angle-right-solid 1")
                                .resizable()
                                .frame(width: 12, height: 24)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
                        }
                    }
                .frame(width: screenWidth - 25, height: 41)
                .background(greenColor)
                .cornerRadius(20.0)
            }.navigationBarBackButtonHidden(true)
            
            
            Spacer()
        }.ignoresSafeArea()
    }
}

struct OpeningScreen_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
