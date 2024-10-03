//
//  NetworkService.swift
//  Pokemon
//
//  Created by Baris Dilekci on 13.12.2023.
//

import Foundation

protocol INetworkService {
    func fetchPokemonData(completion: @escaping (Swift.Result<PokemonList, Error>) -> ())
    func fetchPokemonDetail(id: Int, completion: @escaping (Swift.Result<PokemonDetail, Error>) -> ())
}

final class NetworkService {
    static let shared = NetworkService()
    let networkManager: INetworkManager = NetworkManager()
}

extension NetworkService: INetworkService {
    func fetchPokemonData(completion: @escaping (Swift.Result<PokemonList, Error>) -> ()) {
        let endpoint = EndPoint.fetchPokemonData
        networkManager.request(endpoint, completion: completion)
    }
    
    func fetchPokemonDetail(id: Int, completion: @escaping (Swift.Result<PokemonDetail, Error>) -> ()) {
        let endpoint = EndPoint.fetchPokemonDetail(id: id)
        
        networkManager.request(endpoint) { (result: Result<PokemonDetail, Error>) in
            switch result {
            case .success(let pokemonDetail):
                print("Fetched Pokémon Detail: \(pokemonDetail)")
                completion(.success(pokemonDetail))
            case .failure(let error):
                print("Error fetching Pokémon detail: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

}
