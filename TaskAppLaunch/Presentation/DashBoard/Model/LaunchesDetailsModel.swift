//
//  LaunchesDetailsModel.swift
//  TaskAppLaunch
//
//  Created by Kishore on 21/01/23.
//

import Foundation

struct LaunchesDetails: Codable {
    let links: Links?
    let static_fire_date_utc: String?
    let static_fire_date_unix: Int?
    let net: Bool?
    let window: Int?
    let rocket: String?
    let success: Bool?
    let failures: [Failure]?
    let details, launchpad: String?
    let flight_number: Int?
    let name, date_utc: String?
    let date_unix: Int?
    let date_local: String?
    let date_precision: String?
    let upcoming: Bool?
    let cores: [Core]?
    let auto_update, tbd: Bool?
    let id: String?
    
    var year : Int? {
        return Int(dateToYear(date: date_local ?? "0")) ?? 0
    }
}

// MARK: - Core
struct Core: Codable {
    let core: String?
    let flight: Int?
    let gridfins, legs, reused, landing_attempt: Bool?
}

// MARK: - Failure
struct Failure: Codable {
    let time: Int?
    let reason: String?
}

// MARK: - Links
struct Links: Codable {
    let patch: Patch?
    let webcast: String?
    let youtube_id: String?
    let article: String?
    let wikipedia: String?
}

// MARK: - Patch
struct Patch: Codable {
    let small, large: String?
}


