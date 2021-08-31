//
//  code_trackerApp.swift
//  code-tracker
//
//  Created by Kaan Koç on 29.08.2021.
//

import SwiftUI
import Firebase

@main
struct code_trackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let network = Network()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(network)

        }

    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
