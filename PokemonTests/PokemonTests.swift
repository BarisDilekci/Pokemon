//
//  PokemonTests.swift
//  PokemonTests
//
//  Created by Baris Dilekci on 13.12.2023.
//

import XCTest
@testable import Pokemon

final class PokemonTests: XCTestCase {
    
    var mockNetworkManager : MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testSuccessfulRequest() {
        let expectedPokemons = PokemonList(results: [
            Pokemon(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        ])
        
        mockNetworkManager.result = .success(expectedPokemons)
        
        let endpoint = EndPoint.fetchPokemonData
        
        mockNetworkManager.request(endpoint) { (result: Result<PokemonList, Error>) in
            switch result {
            case .success(let pokemonList):
                XCTAssertEqual(pokemonList.results.count  , expectedPokemons.results.count)
                XCTAssertEqual(pokemonList.results[0].name, expectedPokemons.results[0].name)
            case .failure(let error):
                XCTFail("Beklenmedik bir hata alındı: \(error)")
            }
        }
        
    }
    
    func testFailedRequest() {
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockNetworkManager.result = .failure(expectedError)
        
        let endpoint = EndPoint.fetchPokemonData
        
        mockNetworkManager.request(endpoint) { (result: Result<PokemonList, Error>) in
            switch result {
            case .success:
                XCTFail("Başarılı bir sonuç beklenmiyordu.")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, expectedError.domain)
                XCTAssertEqual((error as NSError).code, expectedError.code)
            }
        }
    }
    
    func testFetchPokemonDataRequest() {
        let endpoint = EndPoint.fetchPokemonData
        
        let expectedURLString = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=25"
        let expectedMethod = HTTPMethodType.get.rawValue
        
        let request = endpoint.request()
        
        XCTAssertEqual(request.url?.absoluteString, expectedURLString)
        XCTAssertEqual(request.httpMethod, expectedMethod)
    }
    
    func testFetchPokemonDetailRequest() {
        let pokemonID = 1
        let endpoint = EndPoint.fetchPokemonDetail(id: pokemonID)
        
        let expectedURLString = "https://pokeapi.co/api/v2/pokemon/1/"
        let expectedMethod = HTTPMethodType.get.rawValue
        
        let request = endpoint.request()
        
        XCTAssertEqual(request.url?.absoluteString, expectedURLString)
        XCTAssertEqual(request.httpMethod, expectedMethod)
    }
}
