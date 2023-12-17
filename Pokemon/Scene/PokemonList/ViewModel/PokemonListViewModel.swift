//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Baris Dilekci on 13.12.2023.
//

import Foundation

protocol IPokemonListViewModel {
    func didErrorList(error: String)
    func didSuccess()
}

final class PokemonListViewModel {
    private let networkService = NetworkService.shared
    
    var pokemons: [Pokemon] = [] // Pokemon dizisi
    
    var delegate: IPokemonListViewModel?
}

extension PokemonListViewModel {
    func fetchPokemonData() {
        networkService.fetchPokemonData { result in
            switch result {
            case .success(let success):
                // Eğer API'nin dönüş türü bir liste ise, burada diziyi güncelleyin.
                self.pokemons = [success]
                self.delegate?.didSuccess()
            case .failure(let error):
                self.delegate?.didErrorList(error: error.localizedDescription)
            }
        }
    }
    
    func fetchPokemonSprite(id: String) -> URL? {
        // İlk Pokemon'un ID'sini kullanarak URL oluşturun
        guard let firstPokemonID = pokemons.first?.results.first?.pokemonID else {
            return nil
        }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(firstPokemonID).png")
    }
}
