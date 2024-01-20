//
//  PokemonList.swift
//  Pokemon
//
//  Created by Baris Dilekci on 15.12.2023.
//
import UIKit
import Kingfisher

final class PokemonListViewController: UIViewController  {

    // MARK: Properties
    private let reuseIdentifier = "PokemonCell"
    private var collectionView: UICollectionView
    private let viewModel = PokemonListViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    
       init() {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           layout.minimumInteritemSpacing = 10
           layout.minimumLineSpacing = 10
           self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           super.init(nibName: nil, bundle: nil)
       }

       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    private func setup() {
        style()
        viewModel.delegate = self
        viewModel.fetchPokemonData()
    }
}

// MARK: - Layouts
extension PokemonListViewController {
    private func style() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        view.addSubview(collectionView)
    }
}



// MARK: - PokemonViewModel
extension PokemonListViewController : IPokemonListViewModel {
    func didErrorList(error: String) {
        print(error)
    }
    
    func didSuccess() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


// MARK: - UICollectionViewDataSource
extension PokemonListViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemons.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonCollectionViewCell
        

        let pokemon = viewModel.pokemons[indexPath.row]

        cell.pokemonImage.kf.setImage(with: pokemon.imageUrl)
        cell.pokemonName.text = pokemon.name

        // PokemonCollectionViewCell'i yapılandır
        //cell.configure(with: pokemon.name, pokemonID: pokemon.pokemonID)

        return cell
    }


    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 100)
    }
}
