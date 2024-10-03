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

final class PokemonListViewController: UIViewController {

    // MARK: - Properties
    private let reuseIdentifier = "PokemonCell"
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tableView
    }()
    
    private let viewModel: PokemonListViewModel

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
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        let pokemon = viewModel.getPokemon(indexPath: indexPath)
        let cellViewModel = PokemonCollectionViewCellViewModel(
            name: pokemon.name ?? "Unknown",
            imageUrl: pokemon.imageUrl ?? URL(string: "default_url_string")!
        )
        cell.accessoryType = .disclosureIndicator
        cell.configure(with: cellViewModel)

        return cell
    }
    
    // MARK: - UITableViewDelegate (optional)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pokemon = viewModel.getPokemon(indexPath: indexPath)
        
        viewModel.fetchPokemonDetail(id: pokemon.id ?? 1) { [weak self] result in
            switch result {
            case .success(let pokemonDetail):
                DispatchQueue.main.async {
                    let detailViewModel = PokemonDetailViewModel(pokemon: pokemonDetail)
                    let detailViewController = PokemonDetailViewController(viewModel: detailViewModel)
                    self?.navigationController?.pushViewController(detailViewController, animated: true)
                }
            case .failure(let error):
                print("Error fetching details: \(error.localizedDescription)")
            }
        }
    }
}
