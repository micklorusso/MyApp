//
//  PokemonData.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

struct PokemonList: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let name: String
    let url: String
}
