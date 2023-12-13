//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Baris Dilekci on 13.12.2023.
//

import Foundation

protocol IPokemonListViewModel {
    func didErrorList(error:String)
    func didSuccess()
}

final class PokemonListViewModel {
    private let networkService = NetworkService.shared
    
    var pokemons : Pokemon?
    var delegate : IPokemonListViewModel?
}

extension PokemonListViewModel {
    func fetchPokemonData() {
        networkService.fetchPokemonData { result in
            switch result {
                
            case .success(let success):
                self.pokemons = success
                self.delegate?.didSuccess()
            case .failure(let error):
                self.delegate?.didErrorList(error: error.localizedDescription)
            }
        }
    }
}
