//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Baris Dilekci on 13.12.2023.
//

import Foundation

struct PokemonCollectionViewCellViewModel {
    let name: String
    let imageUrl: URL
}

final class PokemonListViewModel {
    private let networkService: INetworkService
    private var pokemons: [Pokemon] = []
    
    init(networkService: INetworkService) {
        self.networkService = networkService
        fetchPokemonData()
    }
    
    var numberOfItemsInSection: Int {
        return pokemons.count
    }
    
    func getPokemon(indexPath: IndexPath) -> Pokemon {
        return pokemons[indexPath.row]
    }
}

extension PokemonListViewModel {
    func fetchPokemonData() {
        networkService.fetchPokemonData { [weak self] result in
            switch result {
            case .success(let success):
                print(success)  // Başarıyla alındı
                self?.pokemons = success.results
            case .failure(let error):
                print("Error fetching Pokémon data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPokemonDetail(id: Int, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        networkService.fetchPokemonDetail(id: id) { result in
            switch result {
            case .success(let pokemonDetail):
                completion(.success(pokemonDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func pokemonCellViewModel(at indexPath: IndexPath) -> PokemonCollectionViewCellViewModel {
        let pokemon = getPokemon(indexPath: indexPath)
        let name = pokemon.name
        let imageUrl = URL(string: "https://pokeapi.co/media/sprites/pokemon/\(pokemon.id ?? 1).png")!
        return PokemonCollectionViewCellViewModel(name: name, imageUrl: imageUrl)
    }
}
