//
//  PokemonList.swift
//  Pokemon
//
//  Created by Baris Dilekci on 15.12.2023.
//
import UIKit

class PokemonList: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, IPokemonListViewModel {
    func didErrorList(error: String) {
        print("error")
    }
    
    func didSuccess() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    

    private let reuseIdentifier = "PokemonCell"
    private var collectionView: UICollectionView
    private let viewModel = PokemonListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchPokemonData()

        // UICollectionViewFlowLayout kullanarak bir düzen belirle
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        // UICollectionView oluştur ve düzeni ata
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self

        // Hücre tipini kaydet
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // UICollectionView'ı view'a ekle
        view.addSubview(collectionView)
    }
    
    // Eklenen başlatıcı
       init() {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           layout.minimumInteritemSpacing = 10
           layout.minimumLineSpacing = 10
           self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           super.init(nibName: nil, bundle: nil)
       }

       // Gerekli olan başlatıcı
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }


    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Veri kaynağınıza göre uygun sayıyı döndürün
        return viewModel.pokemons?.results.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonCollectionViewCell
        let index = viewModel.pokemons?.results[indexPath.row]
       // cell.configure(with: index?.name, pokemonID: index?.url)

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Hücre boyutlarını ayarlayın
        return CGSize(width: view.frame.width - 20, height: 100)
    }

}
