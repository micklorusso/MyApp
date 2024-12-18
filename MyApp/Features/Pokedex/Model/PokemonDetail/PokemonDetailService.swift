//
//  PokemonDetailService.swift
//  MyApp
//
//  Created by Lorusso, Michele on 26/11/24.
//

import Foundation

protocol PokemonDetailServiceDelegate {
    func didUpdatePokemonDetail(
        _ pokemonApi: PokemonDetailService, pokemon: PokemonDetailModel)
    func didFailWithError(_ error: Error)
}

class PokemonDetailService: PokemonApi {
    var delegate: PokemonDetailServiceDelegate?

    func fetchData(with id: Int) async {

        do {
            let (pokemonSpecies, pokemonDetail) = try await (
                fetchPokemonSpecies(id: id),
                fetchPokemonDetail(id: id)
            )

            let pokemonDetailModel = PokemonDetailModel(
                pokemonDetail: pokemonDetail, pokemonSpecies: pokemonSpecies)
            delegate?.didUpdatePokemonDetail(self, pokemon: pokemonDetailModel)

        } catch {
            delegate?.didFailWithError(error)
        }
    }

    func fetchPokemonSpecies(id: Int) async throws -> PokemonSpecies {
        let stringUrl = "\(Routes.API.apiURL)\(Routes.API.pokemonSpecies)\(id)"
        guard let url = URL(string: stringUrl) else {
            throw NSError(domain: "InvalidURL", code: 1, userInfo: nil)
        }
        return try await performRequest(with: url)
    }

    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        let stringUrl = "\(Routes.API.apiURL)\(Routes.API.pokemonDetail)\(id)"
        guard let url = URL(string: stringUrl) else {
            throw NSError(domain: "InvalidURL", code: 1, userInfo: nil)
        }
        return try await performRequest(with: url)
    }

}
