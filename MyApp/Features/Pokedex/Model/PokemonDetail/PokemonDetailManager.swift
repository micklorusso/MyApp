//
//  PokemonDetailManager.swift
//  MyApp
//
//  Created by Lorusso, Michele on 26/11/24.
//

class PokemonDetailManager{
    
    let pokemonDetailService = PokemonDetailService()
    var pokemonDetail: PokemonDetailModel?
    
    init(id: Int){
        Task{
            await pokemonDetailService.fetchData(with: id)
        }
    }
    
}

