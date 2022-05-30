//
//  StarRepo.swift
//  code-tracker
//
//  Created by Kaan Koç on 29.05.2022.
//

import Foundation
struct StarredRepo: Codable {
    var id: Int
    var full_name: String
    var language: String
    var stargazers_count: Int
}
