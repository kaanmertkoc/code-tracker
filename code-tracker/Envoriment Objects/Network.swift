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
    @Published var weeklyCommits: [WeeklyCommit] = []
    
    
    func getRepos() {
        guard let url = URL(string: "http://localhost:5000/api/repos") else {
            fatalError("missing url")
        }
        let token = UserDefaults.standard.string(forKey: "access_token")
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
                        for repo in self.repos {
                            print(repo.full_name)
                            self.getWeeklyCommits(repoName: repo.full_name)
                        }
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    func getWeeklyCommits(repoName: String) {
        guard let url = URL(string: "http://localhost:5000/api/commits/dayly") else {
            fatalError("missing url")
        }
        let token = UserDefaults.standard.string(forKey: "access_token")
        print(token!)
        let json: [String: Any] = ["access_token": "\(token!)", "repoName": "\(repoName)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
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
                        let decodedWeeklyCommits = try JSONDecoder().decode(WeeklyCommit.self, from: data)
                        print(decodedWeeklyCommits)
                        self.weeklyCommits.append(decodedWeeklyCommits)
                        
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
