//
//  Routes.swift
//  MyApp
//
//  Created by Lorusso, Michele on 04/12/24.
//

struct Routes {
    struct Local {
        static let pokedexToDetail = "PokedexToDetail"
    }

    struct API {
        static let pokemonPerPage = 10
        static let apiURL = "https://pokeapi.co/api/v2/"
        static let pokemonList = "pokemon?limit=\(pokemonPerPage)&offset="
        static let pokemonSpecies = "pokemon-species/"
        static let pokemonDetail = "pokemon/"
    }
}
