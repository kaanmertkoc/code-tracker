//
//  Network.swift
//  code-tracker
//
//  Created by Kaan Koç on 31.08.2021.
//

import SwiftUI



class Network: ObservableObject {
    @Published var repos: [Repo] = []
    @Published var commits: [[Int]] = [[]]
    
    
    func getRepos() {
        guard let url = URL(string: "http://localhost:5000/api/repos") else {
            fatalError("missing url")
        }
        let token = UserDefaults.standard.string(forKey: "access_token")
        print(token!)
        let json: [String: Any] = ["access_token": "\(token!)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue( "Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
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
    
    func getCommits(full_name: String) {
        guard let url = URL(string: "http://localhost:5000/api/commits/stats") else {
            fatalError("missing url")
        }
        let token = UserDefaults.standard.string(forKey: "access_token")
        print(token!)
        let json: [String: Any] = ["access_token": "\(token!)", "repoName": "\(full_name)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue( "Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
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
                        let decodedCommits = try JSONDecoder().decode([[Int]].self, from: data)
                        print(decodedCommits)
                        
                        for i in 0..<self.repos.capacity {
                            if self.repos[i].full_name == full_name {
                                let newRepo = Repo(id: self.repos[i].id, full_name: self.repos[i].full_name, language: self.repos[i].language, commits: decodedCommits)
                                self.repos[i] = newRepo
                            }
                        }
                        
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
