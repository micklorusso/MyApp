//
//  PokemonModel.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

struct PokemonModel{
    var name: String
    var image: String
    var types: [String] = []
    var order: Int
    
    init(pokemonListData: PokemonListData, pokemonDetail: PokemonDetail){
        self.name = pokemonListData.name
        self.image = pokemonDetail.sprites.front_default
        for pokemonType in pokemonDetail.types{
            types.append(pokemonType.type.name)
        }
        self.order = pokemonDetail.order
    }
    
}
