//
//  PokemonApi.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//
import Foundation

protocol PokemonListServiceDelegate{
    func didUpdatePokemonList(_ pokemonApi: PokemonApi, pokemon: [PokemonListModel])
    func didFailWithError(_ error: Error)
}



class PokemonListService: PokemonApi {
    var delegate: PokemonListServiceDelegate?

    func fetchData(offset: Int) async {
        let stringUrl = "\(Constants.apiURL)\(Constants.Routes.pokemonList)\(offset)"
        guard let url = URL(string: stringUrl) else { return }
        var fetchedPokemon: [PokemonListModel] = []
        do {
            let pokemonList: PokemonList = try await performRequest(with: url)
            for result in pokemonList.results {
                if let pokemonURL = URL(string: result.url) {
                    do {
                        let pokemonDetail: PokemonDetail = try await performRequest(with: pokemonURL)
                        let pokemonModel = PokemonListModel(pokemonDetail: pokemonDetail)
                        fetchedPokemon.append(pokemonModel)
                    } catch {
                        delegate?.didFailWithError(error)
                    }
                }
            }
            delegate?.didUpdatePokemonList(self, pokemon: fetchedPokemon)
        } catch {
            delegate?.didFailWithError(error)
        }
    }
    
}
