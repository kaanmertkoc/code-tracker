//
//  WeeklyCommit.swift
//  code-tracker
//
//  Created by Kaan Koç on 2.09.2021.
//

import Foundation

class WeeklyCommit: Codable {
    var total: Int
    var week: Int
    var days: [Int]
}
