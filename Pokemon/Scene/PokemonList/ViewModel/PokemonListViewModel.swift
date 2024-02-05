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
    private let networkService : INetworkService
    private var pokemons: [Pokemon] = []
    
    init(networkService: INetworkService) {
        self.networkService = networkService
        fetchPokemonData()
    }
    
    var numberOfItemsInSection : Int {
        pokemons.count
    }
    
    func getPokemon(indexPath: IndexPath) -> Pokemon {
        return pokemons[indexPath.row]
    }
}

extension PokemonListViewModel {
    func fetchPokemonData() {
        networkService.fetchPokemonData { result in
            switch result {
            case .success(let success):
                print(result)
                self.pokemons = success.results
            case .failure(let error):
                print(error)
            }
        }
    }

}
