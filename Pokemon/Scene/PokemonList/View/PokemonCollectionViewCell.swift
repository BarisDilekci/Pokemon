//
//  PokemonCollectionViewCell.swift
//  Pokemon
//
//  Created by Baris Dilekci on 15.12.2023.
//

import UIKit
import Kingfisher

class PokemonCollectionViewCell: UICollectionViewCell {
    let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let pokemonName: UILabel = {
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
   
    // PokemonCollectionViewCell içinde configure fonksiyonu
    func configure(with name: String?, pokemonID: String?) {
        pokemonName.text = name ?? "Unknown Pokemon"
        
        if let pokemonIDString = pokemonID, let id = Int(pokemonIDString) {
            let imageURLString =  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
            if let url = URL(string: imageURLString) {
                pokemonImage.kf.setImage(with: url)
            } else {
                pokemonImage.image = UIImage(named: "defaultImage")
            }
        } else {
            pokemonImage.image = UIImage(named: "defaultImage")
        }
    }

}
