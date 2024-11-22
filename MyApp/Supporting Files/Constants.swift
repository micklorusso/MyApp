//
//  Constants.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

struct K{
    static let numberOfPokemonsToLoad = 151
    static let apiURL = "https://pokeapi.co/api/v2/"
    struct Routes{
        static let pokemonList = "pokemon?limit=\(numberOfPokemonsToLoad)"
    }
    struct Cells{
        static let pokemonCellIdentifier = "ReusablePokemonCell"
        static let pokemonCellNibName = "PokemonCell"
    }

}
