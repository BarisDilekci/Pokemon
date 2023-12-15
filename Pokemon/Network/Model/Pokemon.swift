//
//  Pokemon.swift
//  Pokemon
//
//  Created by Baris Dilekci on 13.12.2023.
//

import Foundation

struct Pokemon: Decodable {
    let count: Int
    let next: String
    let results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let name: String
    let url: String
}
