//
//  iTunes.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let iTunse = try? JSONDecoder().decode(ITunse.self, from: jsonData)

import Foundation

// MARK: - ITunse
struct iTunes: Codable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let isGameCenterEnabled: Bool
}


//struct iTunes: Codable {
//    let resultCount: Int
//    let app: [App]
//}
//struct App: Codable {
//    let isGameCenterEnabled: Bool
//    let artworkUrl100: String
//    let screenshotUrls: [String]
//    let artworkUrl512: String
//    let artistViewURL: String
//    let artworkUrl60: String
//    let kind: String
//    let currency: String 
//    let minimumOsVersion: String
//    let trackCensoredName: String
//    let releaseNotes: String // 새로운 소식
//    let artistName: String
//    let description: String // 앱 설명
//}
