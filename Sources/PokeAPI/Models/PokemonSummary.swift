//
//  PokemonSummary.swift
//  
//
//  Created by Simon Deutsch on 12.12.21.
//

import Foundation

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
