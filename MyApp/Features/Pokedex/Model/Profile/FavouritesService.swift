//
//  FavouritesService.swift
//  MyApp
//
//  Created by Lorusso, Michele on 02/12/24.
//

import Foundation

protocol FavouritesServiceDelegate {
    func didUpdatePokemonFavourites(
        _ pokemonApi: PokemonApi, pokemon: [PokemonListModel])
    func didFailWithError(_ error: Error)
}

class FavouritesService: PokemonApi {
    var delegate: FavouritesServiceDelegate?

    func fetchData(forIds ids: [Int]) async {
        var fetchedPokemon: [PokemonListModel] = []
        do {
            for id in ids {
                let url = "\(Routes.API.apiURL)\(Routes.API.pokemonDetail)\(id)"
                if let pokemonURL = URL(string: url) {
                    let pokemonDetail: PokemonDetail = try await performRequest(
                        with: pokemonURL)
                    let pokemonModel = PokemonListModel(
                        pokemonDetail: pokemonDetail)
                    fetchedPokemon.append(pokemonModel)
                }
            }
            delegate?.didUpdatePokemonFavourites(self, pokemon: fetchedPokemon)
        } catch {
            delegate?.didFailWithError(error)
        }
    }
}
