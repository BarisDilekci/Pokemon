//
//  PokemonCollectionViewCell.swift
//  Pokemon
//
//  Created by Baris Dilekci on 15.12.2023.
//

import UIKit
import Kingfisher

final class PokemonCollectionViewCell: UICollectionViewCell {
   private  let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var pokemonName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func configure(with viewModel: PokemonCollectionViewCellViewModel) {
        self.pokemonName.text = viewModel.name
        
        if let url = URL(string: viewModel.imageUrl) {
            self.pokemonImage.kf.setImage(with: url)
        }
        
    }
    private func setupViews() {
        addSubview(pokemonImage)
        addSubview(pokemonName)
        
        NSLayoutConstraint.activate([
            // ImageView Constraints
            pokemonImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            pokemonImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            pokemonImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            pokemonImage.widthAnchor.constraint(equalToConstant: 80), // Ayarlamak istediğiniz genişliği belirleyebilirsiniz
            
            // Label Constraints
            pokemonName.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor, constant: 8),
            pokemonName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            pokemonName.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
