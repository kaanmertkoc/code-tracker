//
//  SignUp.swift
//  code-tracker
//
//  Created by Kaan Koç on 30.08.2021.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SignUp: View {
    
    var provider = OAuthProvider(providerID: "github.com")
    @State var isActive = false
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                Image("signUp")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .cornerRadius(40)
                    .padding(.init(top: 80, leading: 0, bottom: 0, trailing: 0))
                
                Text("Code Tracker")
                    .foregroundColor(Color.white)
                    .font(.system(size: 30, weight: .medium))
                    .padding(.init(top: 50, leading: 0, bottom: 0, trailing: 0))
                NavigationLink(
                    destination: HomePage(),
                    isActive: $isActive) {}
                    .navigationBarBackButtonHidden(true)
                   
                Button {
                    
                    provider.scopes = ["user:email"]
                    provider.getCredentialWith(nil) { credential, error in
                        if error != nil {
                            // Handle error.
                        }
                        if credential != nil {
                            Auth.auth().signIn(with: credential!) { authResult, error in
                                if error != nil {
                                    print(error!)
                                    return
                                }
                                guard let oauthCredential = authResult!.credential as? OAuthCredential else { return }
                                
                                if oauthCredential.accessToken != nil {
                                    UserDefaults.standard.setValue(oauthCredential.accessToken!, forKey: "access_token")
                                    isActive.toggle()
                                }
                                else {
                                    print("error getting token")
                                }
                                
      
                            }
                        }
                    }
                    
                } label: {
                    HStack {
                        Spacer()
                        Text("Sign Up With Github")
                            .foregroundColor(Color.white)
                            .font(.system(size: 20, weight: .medium))
                        Spacer()
                        Image("githubLogo")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
                    }
                }
                .frame(width: 315, height: 50)
                .background(greenColor)
                .cornerRadius(10.0)
                .padding()
                
                Spacer()
            }
        }.ignoresSafeArea()
        
    }
}

struct SignUp_Preview: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
