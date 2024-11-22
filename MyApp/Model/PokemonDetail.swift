//
//  PokemonDetail.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

struct PokemonDetail: Decodable{
    let types: [PokemonType]
    let sprites: Sprites
    let order: Int
}

struct PokemonType: Decodable{
    let type: TypeInfo
}

struct TypeInfo: Decodable{
    let name: String
}

struct Sprites: Decodable{
    let front_default: String
}
