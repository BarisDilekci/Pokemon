//
//  PokemonList.swift
//  Pokemon
//
//  Created by Baris Dilekci on 15.12.2023.
//
import UIKit


enum PokemonListViewBuilder {
    static func generate() -> UIViewController {
        let viewModel = PokemonListViewModel(networkService: NetworkService.shared)
        let viewController = PokemonListViewController(viewModel: viewModel)
        return viewController
    }
}

final class PokemonListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: PokemonListViewModel
    private let reuseIdentifier = "PokemonCell"
    
    //MARK: - UI Elements
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        return tableView
    }()
    
    
    // MARK: - Lifecycle
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.onPokemonDetailFetched = { [weak self] pokemonDetail in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let detailViewModel = PokemonDetailViewModel(pokemon: pokemonDetail)
                let detailViewController = PokemonDetailViewController(viewModel: detailViewModel)
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.viewDidLoad()
    }
    
    deinit {
        tableView.delegate = nil
        tableView.dataSource = nil
    }
    
    
    //MARK: Functions
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
        return viewModel.numberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(at: indexPath, tableView: tableView)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}
