//
//  Network.swift
//  code-tracker
//
//  Created by Kaan Koç on 31.08.2021.
//

import SwiftUI

class Network: ObservableObject {
    @Published var repos: [Repo] = []
    
    func getRepos() {
        guard let url = URL(string: "http://localhost:5000/api/repos") else {
            fatalError("missing url")
        }
        let token = UserDefaults.standard.string(forKey: "access_token")
        print(token!)
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Authorization", forHTTPHeaderField: "Bearer \(String(describing: token))")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {return }
            
            if response.statusCode == 200 {
                guard let data = data else {return}
                DispatchQueue.main.async {
                    do {
                        let decodedRepos = try JSONDecoder().decode([Repo].self, from: data)
                        self.repos = decodedRepos
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
