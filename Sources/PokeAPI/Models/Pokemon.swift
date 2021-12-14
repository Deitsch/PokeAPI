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
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let stats: [PokemonStat]
    let abilities: [PokemonAbility]
    let sprites: PokemonSprites

    // MARK: - TypeElement
    struct PokemonType: Codable {
        let type: String
        
        enum RootCodingKeys: String, CodingKey {
            case slot
            case type
        }
        
        init(from decoder: Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
            let typeContainer = try rootContainer.nestedContainer(keyedBy: NameUrlCodingKeys.self, forKey: .type)
            type = try typeContainer.decode(String.self, forKey: .name)
        }
    }
    
    struct PokemonStat: Codable {
        let name: String
        let baseStat: Int
        
        enum RootCodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case stat
        }
        
        init(from decoder: Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
            baseStat = try rootContainer.decode(Int.self, forKey: .baseStat)
            let statContainer = try rootContainer.nestedContainer(keyedBy: NameUrlCodingKeys.self, forKey: .stat)
            name = try statContainer.decode(String.self, forKey: .name)
        }
    }
    
    struct PokemonAbility: Codable {
        let name: String
        let isHidden: Bool
        
        enum RootCodingKeys: String, CodingKey {
            case isHidden = "is_hidden"
            case ability
        }
        
        init(from decoder: Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
            isHidden = try rootContainer.decode(Bool.self, forKey: .isHidden)
            let abilityContainer = try rootContainer.nestedContainer(keyedBy: NameUrlCodingKeys.self, forKey: .ability)
            name = try abilityContainer.decode(String.self, forKey: .name)
        }
    }
    
    struct PokemonSprites: Codable {
        let frontDefault: String
        let frontFemale: String?
        let frontShiny: String?
        let frontShinyFemale: String?
        
        let backDefault: String
        let backFemale: String?
        let backShiny: String?
        let backShinyFemale: String?
        
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
        
        init(from decoder: Decoder) throws {
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
