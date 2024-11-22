//
//  PokemonApi.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//
import Foundation

protocol PokemonApiDelegate{
    func didUpdatePokemon(_ pokemonApi: PokemonApi, pokemon: PokemonModel)
    func didFailWithError(_ error: Error)
}

class PokemonApi: NSObject {
    var delegate: PokemonApiDelegate?

    func fetchData() {
          let stringUrl = "\(K.apiURL)\(K.Routes.pokemonList)"
          let url = URL(string: stringUrl)
          if let safeURL = url{
              performRequest(with: safeURL) { (result: Result<PokemonList, Error>) in
                  switch result {
                  case .success(let pokemon):
                      for pokemonListData in pokemon.results{
                          if let safePokemonURL = URL(string: pokemonListData.url){
                              self.performRequest(with: safePokemonURL) { (result: Result<PokemonDetail, Error>) in
                                  switch result{
                                  case .success(let pokemonDetail):
                                      let pokemonModel = PokemonModel(pokemonListData: pokemonListData, pokemonDetail: pokemonDetail)
                                      self.delegate?.didUpdatePokemon(self, pokemon: pokemonModel)
                                  case .failure(let error):
                                      self.delegate?.didFailWithError(error)
                                  }
                              }
                          }
                      }
                  case .failure(let error):
                      self.delegate?.didFailWithError(error)
                  }
              }
          }
      }
    
    func performRequest<T: Decodable>(with url: URL, completion: @escaping (Result<T, Error>) -> Void) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let safeData = data {
                    if let decodedData: T = self.parseJSON(pokemonData: safeData) {
                        completion(.success(decodedData))
                    } else {
                        completion(.failure(NSError(domain: "DecodingError", code: 1, userInfo: nil)))
                    }
                }
            }
            task.resume()
        }
        
        func parseJSON<T: Decodable>(pokemonData: Data) -> T? {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: pokemonData)
                return decodedData
            } catch {
                delegate?.didFailWithError(error)
                return nil
            }
        }
}
