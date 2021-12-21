//
//  PokemonSummary.swift
//  
//
//  Created by Simon Deutsch on 12.12.21.
//

import Foundation

public class PokemonSummary: Codable {
    public let id: Int
    public let name: String
    public let url: String
    public let spriteUrl: String
    
    required public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: NameUrlCodingKeys.self)
        name = try rootContainer.decode(String.self, forKey: .name)
        url = try rootContainer.decode(String.self, forKey: .url)
        // create values not provided in the api but needed for proper displaying a list
        id = Int(URL(string: url)!.lastPathComponent)!
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
