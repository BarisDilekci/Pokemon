//
//  ViewController.swift
//  Pokemon
//
//  Created by Baris Dilekci on 13.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        viewModel.delegate = self
        viewModel.fetchPokemonData()
    }


}

extension ViewController: IPokemonListViewModel {
    func didErrorList(error: String) {
        print("error")
    }
    
    func didSuccess() {
        DispatchQueue.main.async {
            self.viewModel.pokemons?.results.forEach({ result in
                print(result)
            })
        }
    }
    
    
}
