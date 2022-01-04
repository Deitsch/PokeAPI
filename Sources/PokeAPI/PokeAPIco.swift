// Wrapper for https://pokeapi.co

import Foundation
import Combine

public class PokeAPIco {
    
    private let apiURL = URL(string: "https://pokeapi.co/api/v2/")!
    private let urlSession: URLSession
    
    public init() {
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func heyPokeApi() -> String {
        return "hey PokeApi"
    }
    
    public func loadPokemon(pagination: Pagination? = nil) -> AnyPublisher<[PokemonSummary], PokeAPIError> {
        var pokemonURL = URLComponents(string: apiURL.appendingPathComponent("pokemon").absoluteString)!
        pokemonURL.queryItems = [
            URLQueryItem(name: "limit", value: "\(pagination?.limit ?? Int.max)"),
            URLQueryItem(name: "offset", value: "\(pagination?.offset ?? 0)")
        ]
        
        var request = URLRequest(url: pokemonURL.url!)
        request.setHttpMethod(.GET)
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw PokeAPIError.internalServerError
                }
                guard httpResponse.statusCode == 200 else {
                    throw PokeAPIError.someError
                }
                return element.data
            }
            .decode(type: PokemonSummaryContainer.self, decoder: JSONDecoder())
            .map { $0.results }
            .mapError { error in
                switch error {
                case is DecodingError:
                    return .decodingError(error as! DecodingError)
                case let err as PokeAPIError:
                    return err
                default:
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func loadPokemon(by id: Int) -> AnyPublisher<Pokemon, PokeAPIError> {
        let pokemonURL = apiURL.appendingPathComponent("pokemon").appendingPathComponent("\(id)")
        
        var request = URLRequest(url: pokemonURL)
        request.setHttpMethod(.GET)
        
        return urlSession.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw PokeAPIError.internalServerError
                }
                guard httpResponse.statusCode == 200 else {
                    throw PokeAPIError.someError
                }
                return element.data
            }
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is DecodingError:
                    return .decodingError(error as! DecodingError)
                case let err as PokeAPIError:
                    return err
                default:
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
