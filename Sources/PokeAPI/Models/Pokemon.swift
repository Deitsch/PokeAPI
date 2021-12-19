//
//  Pokemon.swift
//  
//
//  Created by Simon Deutsch on 11.12.21.
//

import Foundation

enum NameUrlCodingKeys: String, CodingKey {
    case name
    case url
}

public class Pokemon: Codable {
    public let id: Int
    public let name: String
    public let height: Int
    public let weight: Int
    public let types: [PokemonType]
    public let stats: [PokemonStat]
    public let abilities: [PokemonAbility]
    public let sprites: PokemonSprites

    // MARK: - TypeElement
    public struct PokemonType: Codable {
        public let type: String
        
        enum RootCodingKeys: String, CodingKey {
            case slot
            case type
        }
        
        public init(from decoder: Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
            let typeContainer = try rootContainer.nestedContainer(keyedBy: NameUrlCodingKeys.self, forKey: .type)
            type = try typeContainer.decode(String.self, forKey: .name)
        }
    }
    
    public struct PokemonStat: Codable {
        public let name: String
        public let baseStat: Int
        
        enum RootCodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case stat
        }
        
        public init(from decoder: Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
            baseStat = try rootContainer.decode(Int.self, forKey: .baseStat)
            let statContainer = try rootContainer.nestedContainer(keyedBy: NameUrlCodingKeys.self, forKey: .stat)
            name = try statContainer.decode(String.self, forKey: .name)
        }
    }
    
    public struct PokemonAbility: Codable {
        public let name: String
        public let isHidden: Bool
        
        enum RootCodingKeys: String, CodingKey {
            case isHidden = "is_hidden"
            case ability
        }
        
        public init(from decoder: Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
            isHidden = try rootContainer.decode(Bool.self, forKey: .isHidden)
            let abilityContainer = try rootContainer.nestedContainer(keyedBy: NameUrlCodingKeys.self, forKey: .ability)
            name = try abilityContainer.decode(String.self, forKey: .name)
        }
    }
    
    public struct PokemonSprites: Codable {
        public let frontDefault: String
        public let frontFemale: String?
        public let frontShiny: String?
        public let frontShinyFemale: String?
        
        public let backDefault: String
        public let backFemale: String?
        public let backShiny: String?
        public let backShinyFemale: String?
        
        enum RootCodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontFemale = "front_female"
            case frontShiny = "front_shiny"
            case frontShinyFemale = "front_shiny_female"
            
            case backDefault = "back_default"
            case backFemale = "back_female"
            case backShiny = "back_shiny"
            case backShinyFemale = "back_shiny_female"
        }
        
        public init(from decoder: Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
            frontDefault = try rootContainer.decode(String.self, forKey: .frontDefault)
            frontFemale = try? rootContainer.decode(String.self, forKey: .frontFemale)
            frontShiny = try rootContainer.decode(String.self, forKey: .frontShiny)
            frontShinyFemale = try? rootContainer.decode(String.self, forKey: .frontShinyFemale)
            
            backDefault = try rootContainer.decode(String.self, forKey: .backDefault)
            backFemale = try? rootContainer.decode(String.self, forKey: .backFemale)
            backShiny = try rootContainer.decode(String.self, forKey: .backShiny)
            backShinyFemale = try? rootContainer.decode(String.self, forKey: .backShinyFemale)
        }
    }
}
