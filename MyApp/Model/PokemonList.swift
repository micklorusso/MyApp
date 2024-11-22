//
//  PokemonData.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

struct PokemonList: Decodable{
    let results: [PokemonListData]
}


struct PokemonListData: Decodable{
    let name: String
    let url: String
}
