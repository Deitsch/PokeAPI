import XCTest
import Combine
@testable import PokeAPI

final class PokeAPITests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func testExample() throws {
        XCTAssertEqual(PokeAPI().heyPokeApi(), "hey PokeApi")
    }
    
    func testLoadPokemon() throws {
        
        var error: Error?
        let expectation = expectation(description: "loadPokemon")
        var pokemonSummaryList: [PokemonSummary] = []
        
        PokeAPI().loadPokemon().sink(receiveCompletion: { result in
            switch result {
            case .finished:
                break
            case .failure(let err):
                error = err
            }
            expectation.fulfill()
        }, receiveValue: { value in
            pokemonSummaryList = value
        }).store(in: &cancellables)
        
        waitForExpectations(timeout: 10)

        XCTAssertNil(error)
        XCTAssertGreaterThan(pokemonSummaryList.count, 0)
    }
    
    func testLoadPokemonById() throws {
        
        var error: Error?
        let expectation = expectation(description: "loadPokemonById")
        var pokemon: Pokemon?
        
        PokeAPI().loadPokemon(by: 1).sink(receiveCompletion: { result in
            switch result {
            case .finished:
                break
            case .failure(let err):
                error = err
            }
            expectation.fulfill()
        }, receiveValue: { value in
            pokemon = value
        }).store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        print(error)
        XCTAssertNil(error)
        XCTAssertEqual(pokemon?.name ?? "", "bulbasaur")
    }
}
