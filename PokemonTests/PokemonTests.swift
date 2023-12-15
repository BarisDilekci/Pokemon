//
//  PokemonTests.swift
//  PokemonTests
//
//  Created by Baris Dilekci on 13.12.2023.
//

import XCTest
@testable import Pokemon

final class PokemonTests: XCTestCase, IPokemonListViewModel {

    var fetchExpectation: XCTestExpectation?


    //MARK: SERVICE TEST
    func test_fetch_pokemon_data() throws {
        let networkService = NetworkService()
        
        let expectation = self.expectation(description: "Fetch Pokemon Data")
        
        networkService.fetchPokemonData { result in
            switch result {
            case .success(let pokemonResponse):
                for pokemon in pokemonResponse.results {
                    XCTAssertFalse(pokemon.name.isEmpty, "Pokemon name should not be empty")
                    XCTAssertGreaterThan(pokemon.name.count, 0, "Pokemon name should have a positive length")
                }
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: LIST TEST
    func test_fetch_viewmodel_data() throws {
        let viewModel = PokemonListViewModel()
        viewModel.delegate = self
        fetchExpectation = expectation(description: "Fetch Pokemon Data")
        viewModel.fetchPokemonData()
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func didErrorList(error: String) {
        XCTFail("Error occurred: \(error)")
        fetchExpectation?.fulfill()
    }
    
    func didSuccess() {
        fetchExpectation?.fulfill()
    }
}
