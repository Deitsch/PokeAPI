//
//  PokemonSummary.swift
//  
//
//  Created by Simon Deutsch on 12.12.21.
//

import Foundation

public class PokemonSummary: Codable {
    let id: String
    let name: String
    let url: String
    let spriteUrl: String
    
    required public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: NameUrlCodingKeys.self)
        name = try rootContainer.decode(String.self, forKey: .name)
        url = try rootContainer.decode(String.self, forKey: .url)
        // create values not provided in the api but needed for proper displaying a list
        id = URL(string: url)!.lastPathComponent
        spriteUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
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
