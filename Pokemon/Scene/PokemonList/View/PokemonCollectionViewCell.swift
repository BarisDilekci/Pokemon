//
//  PokemonCollectionViewCell.swift
//  Pokemon
//
//  Created by Baris Dilekci on 15.12.2023.
//

import UIKit
import Kingfisher

final class PokemonTableViewCell: UITableViewCell {
    private let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pokemonName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func configure(with viewModel: PokemonCollectionViewCellViewModel) {
        self.pokemonName.text = viewModel.name
        self.pokemonImage.kf.setImage(with: viewModel.imageUrl)
    }
    
    private func setupViews() {
        contentView.addSubview(pokemonImage)
        contentView.addSubview(pokemonName)

        NSLayoutConstraint.activate([
            // ImageView Constraints
            pokemonImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pokemonImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            pokemonImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            pokemonImage.widthAnchor.constraint(equalToConstant: 80),
            
            // Label Constraints
            pokemonName.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor, constant: 16),
            pokemonName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pokemonName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
