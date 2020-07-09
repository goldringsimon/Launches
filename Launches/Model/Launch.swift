//
//  Launch.swift
//  Launches
//
//  Created by Simon Goldring on 7/8/20.
//  Copyright © 2020 Simon Goldring. All rights reserved.
//

import Foundation

struct Launch: Codable, Hashable {
    static func == (lhs: Launch, rhs: Launch) -> Bool {
        return lhs.flightNumber == rhs.flightNumber
    }
    
    struct Links: Codable {
        struct Patch: Codable {
            let small: String?
            let large: String?
        }
        
        let patch: Patch
        let wikipedia: String?
    }
    
    let name: String
    let flightNumber: Int
    let details: String?
    let dateUtc: String
    let success: Bool?
    let links: Links
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(flightNumber)
    }
}
