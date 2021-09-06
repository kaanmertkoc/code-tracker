//
//  Home.swift
//  code-tracker
//
//  Created by Kaan Koç on 2.09.2021.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct Home: View {
    @EnvironmentObject var network: Network
    var provider = OAuthProvider(providerID: "github.com")
    
    func refreshToken() {
        provider.scopes = ["user:email", "repo"]
        provider.getCredentialWith(nil) { credential, error in
            if error != nil {
                // Handle error.
            }
            if credential != nil {
                Auth.auth().currentUser?.reauthenticate(with: credential!, completion: { authResult, error in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    guard let oauthCredential = authResult!.credential as? OAuthCredential else {return}
                    
                    if oauthCredential.accessToken != nil {
                        print(oauthCredential.accessToken!)
                        UserDefaults.standard.setValue(oauthCredential.accessToken!, forKey: "access_token")
                    }
                    else {
                        print("error getting token")
                    }
                })
            }
        }
    }
    
    var body: some View {
        TabView {
            if network.repos.capacity > 0 {
                HomePage(repos: network.repos)
                    .tabItem{
                        Label("Home", systemImage: "house.fill")
                    }
                
                StatsPage(repos: network.repos)
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar.xaxis")
                    }
                                 
            }
            else {
                ProgressView("Loading")
            }
            
            
        }.foregroundColor(Color.black)
        .onAppear() {
            refreshToken()
            network.getRepos()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
