//
//  Characters.swift
//  BreakingBad
//
//  Created by Алексей on 08.08.2022.
//

import Foundation

struct Character: Decodable {
    
    let name: String?
    let img: String?
    let status: Status?
    let nickname: String?
    let portrayed: String?
    
    
    
    init (characterData: [String: Any]){
        name = characterData["name"] as? String
        img = characterData["img"] as? String
        status = characterData["status"] as? Status
        nickname = characterData["nickname"] as? String
        portrayed = characterData["portrayed"] as? String
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let charactersData = value as? [[String: Any]] else { return [] }
        return charactersData.compactMap { Character(characterData: $0) }
    }
}

enum Status: String, Codable {
    
    case alive = "Alive"
    case deceased = "Deceased"
    case presumedDead = "Presumed dead"
    case unknown = "Unknown"
}

