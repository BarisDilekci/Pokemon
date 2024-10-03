//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Barış Dilekçi on 2.10.2024.
//

final class PokemonDetailViewModel {
    let pokemonName: String
    let pokemonID: Int
    let height: Int
    let weight: Int

    init(pokemon: PokemonDetail) {
        self.pokemonName = pokemon.name
        self.pokemonID = pokemon.id
        self.height = pokemon.height
        self.weight = pokemon.weight
    }
}
