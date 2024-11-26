//
//  PokemonDetail.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

struct PokemonDetail: Decodable{
    let name: String?
    let types: [PokemonType]?
    let sprites: Sprites?
    let id: Int?
    let order: Int?
    let height: Int?
    let weight: Int?
    let abilities: [Ability]?
    let stats: [Stat]?
}

struct Ability: Decodable{
    let ability: AbilityInfo
}

struct AbilityInfo: Decodable{
    let name: String
}

struct Stat: Decodable{
    let base_stat: Int
    let stat: StatInfo
}

struct StatInfo: Decodable{
    let name: String
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
