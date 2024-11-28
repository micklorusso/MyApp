//
//  PokemonModel.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

import UIKit

struct PokemonListModel{
    var name: String?
    var image: String?
    var types: [String] = []
    var order: Int?
    var id: Int?
    
    init(pokemonDetail: PokemonDetail){
        self.name = pokemonDetail.name
        self.image = pokemonDetail.sprites?.front_default
        if let pokemonTypes = pokemonDetail.types{
            for pokemonType in pokemonTypes{
                types.append(pokemonType.type.name)
            }
        }
        self.order = pokemonDetail.order
        self.id = pokemonDetail.id
    }
    
}
