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
    @Published var weeklyCommits: WeeklyCommit = WeeklyCommit(total: 0, week: 0, days: [])
    
    
    
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
                        self.weeklyCommits = decodedWeeklyCommits
                        
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    func getAllCommits(repoName: String, index: Int) {
        guard let url = URL(string: "http://localhost:5000/api/commits/weekly") else {
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
                        let decodedWeeklyCommits = try JSONDecoder().decode([Int].self, from: data)
                        print(decodedWeeklyCommits)
                        self.repos[index].commitsPerWeek = decodedWeeklyCommits
                        
                    } catch let error {
                        print("Error decoding: ", error, repoName)
                    }
                }
            }
        }
        dataTask.resume()
    }
    func getCommitDetails(repoName: String) {
        guard let url = URL(string: "http://localhost:5000/api/commits/stats") else {
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
                        let decodedCommitDetails = try JSONDecoder().decode([[Int]].self, from: data)
                        self.commits = decodedCommitDetails
                    } catch let error {
                        print("Error decoding: ", error, repoName)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
