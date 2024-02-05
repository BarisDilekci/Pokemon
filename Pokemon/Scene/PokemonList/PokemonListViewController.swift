//
//  PokemonList.swift
//  Pokemon
//
//  Created by Baris Dilekci on 15.12.2023.
//
import UIKit
import Kingfisher

enum PokemonListViewBuilder {
    static func generate() -> UIViewController {
        let viewModel = PokemonListViewModel(networkService: NetworkService.shared)
        let viewController = PokemonListViewController(viewModel: viewModel)
        return viewController
    }
}

final class PokemonListViewController: UIViewController  {

    // MARK: Properties
    private let reuseIdentifier = "PokemonCell"
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        return collectionView
    }()
    private let viewModel : PokemonListViewModel?

    // MARK: - Lifecycle
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    
   

    private func setup() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
}

// MARK: - UICollectionViewDataSource
extension PokemonListViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
                as? PokemonCollectionViewCell
        else { return UICollectionViewCell() }
        let pokemon = viewModel?.getPokemon(indexPath: indexPath)
        let cellViewModel = PokemonCollectionViewCellViewModel(name: pokemon?.name ?? "", imageUrl: "")
        cell.configure(with: cellViewModel)

        return cell
    }


    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 100)
    }
}
