//
//  Model.swift
//  integration
//
//  Created by Taras on 22.04.2025.
//

import Foundation
import FirebaseDatabase

// MARK: - App Model
struct App: Codable {
    let accessByRoles: [Int]
    let active: Bool
    let appId: Int
    let name: String
    let offers: [String: Offer]?
}

//struct AccessByRoles: Codable {
//    var zero: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case zero = "0"
//    }
//}

// MARK: - Offer Model
struct Offer: Codable {
    let affId: String
    let campaignId: Int
    let geo: String
    let homeLink: String
    let percentage: Int
    let teamName: String
    let trackLink: String
}

// MARK: - Apps Container
struct AppsContainer: Codable {
    var apps: [String: App]
}

