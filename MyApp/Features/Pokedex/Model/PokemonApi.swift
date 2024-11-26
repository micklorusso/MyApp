//
//  PokemonApi.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//
import Foundation


class PokemonApi{


    func performRequest<T: Decodable>(with url: URL) async throws -> T {
        let session = URLSession(configuration: .default)
        let (data, _) = try await session.data(from: url)
        return try parseJSON(pokemonData: data)
    }

    func parseJSON<T: Decodable>(pokemonData: Data) throws -> T {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: pokemonData)
            return decodedData
        } catch {
            throw NSError(domain: "DecodingError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode JSON: \(error)"])
        }
    }
}
