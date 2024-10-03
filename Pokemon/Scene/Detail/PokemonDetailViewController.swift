//
//  PokemonDetailViewController.swift
//  Pokemon
//
//  Created by Barış Dilekçi on 2.10.2024.
//
import Foundation
import UIKit

final class PokemonDetailViewController: UIViewController {
    
    private let viewModel: PokemonDetailViewModel
    
    private let nameLabel = UILabel()
    private let heightLabel = UILabel()
    private let weightLabel = UILabel()
    
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Add and layout labels
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameLabel)
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            heightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            
            weightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func loadData() {
        nameLabel.text = viewModel.pokemonName
        heightLabel.text = "Height: \(viewModel.height) decimetres"
        weightLabel.text = "Weight: \(viewModel.weight) hectograms"
    }
}
