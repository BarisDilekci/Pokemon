//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Barış Dilekçi on 2.10.2024.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)


import Foundation

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
}


