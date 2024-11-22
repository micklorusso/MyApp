//
//  PokedexManager.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

class PokedexManager{
    var pokedex: [PokemonModel] = []
    let pokemonApi = PokemonApi()
    
    init() {
        pokemonApi.fetchData()
    }
    
    func addPokemon(_ pokemon: PokemonModel){
        pokedex.append(pokemon)
        pokedex.sort{ $0.order < $1.order}
    }
    
    func getPokedexCount() -> Int{
        return pokedex.count
    }
    
    func getPokemon(at index: Int) -> PokemonModel{
        return pokedex[index]
    }
}
