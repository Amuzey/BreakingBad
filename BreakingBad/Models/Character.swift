//
//  Characters.swift
//  BreakingBad
//
//  Created by Алексей on 08.08.2022.
//

import Foundation

struct Character: Decodable {
    
    let name: String
    let img: String
    let status: Status
    let nickname: String
    let portrayed: String
}

enum Status: String, Codable {
    
    case alive = "Alive"
    case deceased = "Deceased"
    case presumedDead = "Presumed dead"
    case unknown = "Unknown"
}

