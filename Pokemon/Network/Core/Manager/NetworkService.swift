//
//  NetworkService.swift
//  Pokemon
//
//  Created by Baris Dilekci on 13.12.2023.
//

import Foundation

protocol INetworkService {
    func fetchPokemonData(completion: @escaping (Swift.Result<PokemonList, Error>) -> ())
}

final class NetworkService {
    static let shared = NetworkService()
    private let networkManager: INetworkManager = NetworkManager()
}

extension NetworkService: INetworkService {
    func fetchPokemonData(completion: @escaping (Swift.Result<PokemonList, Error>) -> ()) {
        let endpoint = EndPoint.fetchPokemonData
        networkManager.request(endpoint, completion: completion)
    }
    
  
}
