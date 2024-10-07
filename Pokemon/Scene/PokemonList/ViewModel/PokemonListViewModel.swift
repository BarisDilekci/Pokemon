//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Baris Dilekci on 13.12.2023.
//

import Foundation
import UIKit

protocol PokemonListViewHomeInterface {
    func viewDidLoad()
    func numberOfItemsInSection() -> Int
    func cellForRow(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell
    func pokemonCellViewModel(at indexPath: IndexPath) -> PokemonCollectionViewCellViewModel?
    func didSelectRow(at indexPath: IndexPath)
}

struct PokemonCollectionViewCellViewModel {
    let name: String
    let imageUrl: URL
}

final class PokemonListViewModel: PokemonListViewHomeInterface {

    private let networkService: INetworkService
    private var pokemons: [Pokemon] = []
    
    var onPokemonDetailFetched: ((PokemonDetail) -> Void)?
    var onError: ((String) -> Void)?
    
    init(networkService: INetworkService) {
        self.networkService = networkService
        fetchPokemonData()
    }
    
    func viewDidLoad() {
        fetchPokemonData()
    }
    
    func numberOfItemsInSection() -> Int {
        return pokemons.count
    }
    
    func getPokemon(indexPath: IndexPath) -> Pokemon {
        return pokemons[indexPath.row]
    }
    
    func pokemonCellViewModel(at indexPath: IndexPath) -> PokemonCollectionViewCellViewModel? {
        let pokemon = getPokemon(indexPath: indexPath)
        let name = pokemon.name ?? "Unknown"
        let imageUrl = pokemon.imageUrl ?? URL(string: "default_url_string")!
        return PokemonCollectionViewCellViewModel(name: name, imageUrl: imageUrl)
    }

    func cellForRow(at indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        if let cellViewModel = pokemonCellViewModel(at: indexPath) {
            cell.configure(with: cellViewModel)
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let pokemon = getPokemon(indexPath: indexPath)
                fetchPokemonDetail(id: pokemon.id ?? 1) { [weak self] result in
                    switch result {
                    case .success(let pokemonDetail):
                        self?.onPokemonDetailFetched?(pokemonDetail)
                    case .failure(let error):
                        self?.onError?(error.localizedDescription)
                    }
                }
    }
    

}

extension PokemonListViewModel {
    private func fetchPokemonData() {
        networkService.fetchPokemonData { [weak self] result in
            switch result {
            case .success(let success):
                print("Pokémon verisi başarıyla alındı: \(success)")
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
}
