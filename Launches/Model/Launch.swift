//
//  Launch.swift
//  Launches
//
//  Created by Simon Goldring on 7/8/20.
//  Copyright © 2020 Simon Goldring. All rights reserved.
//

import Foundation

struct Launch: Codable {
    struct Links: Codable {
        
    }
    
    let name: String
    let flightNumber: Int
    let details: String
    let dateUtc: Date
    let links: Links
}
