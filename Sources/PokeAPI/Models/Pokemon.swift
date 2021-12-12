//
//  Pokemon.swift
//  
//
//  Created by Simon Deutsch on 11.12.21.
//

import Foundation

public class Pokemon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonType]

    // MARK: - TypeElement
    struct PokemonType: Codable {
        let type: String
        
        enum RootCodingKeys: String, CodingKey {
            case slot
            case type
        }
        
        enum TypeCodingKeys: String, CodingKey {
            case name
            case url
        }
        
        init(from decoder: Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
            let typeContainer = try rootContainer.nestedContainer(keyedBy: TypeCodingKeys.self, forKey: .type)
            type = try typeContainer.decode(String.self, forKey: .name)
        }
    }

}

public class PokemonSummary: Codable {
    let name: String
    let url: String
}

public class PokemonSummaryContainer: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonSummary]
}

public struct Pagination {
    let limit: Int
    let offset: Int
}
