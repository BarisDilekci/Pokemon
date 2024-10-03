//
//  MockNetworkManager.swift
//  Pokemon
//
//  Created by Barış Dilekçi on 3.10.2024.
//

import Foundation

class MockNetworkManager: INetworkManager {
    var result: Swift.Result<PokemonList, Error>?
    
    func request<T>(_ endpoint: EndPoint, completion: @escaping (Swift.Result<T, Error>) -> ()) where T : Decodable {
        if let result = result as? Swift.Result<T, Error> {
            completion(result)
        }
    }
}
