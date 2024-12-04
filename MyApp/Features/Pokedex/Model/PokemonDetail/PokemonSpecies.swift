//
//  PokemonSpecies.swift
//  MyApp
//
//  Created by Lorusso, Michele on 25/11/24.
//

struct PokemonSpecies: Codable {
    let genera: [Genus]
    let egg_groups: [EggGroup]
    let gender_rate: Int
    let color: Color
}

struct Genus: Codable {
    let genus: String
    let language: Language
}

struct Language: Codable {
    let name: String
}

struct EggGroup: Codable {
    let name: String
}

struct Color: Codable {
    let name: String
}
