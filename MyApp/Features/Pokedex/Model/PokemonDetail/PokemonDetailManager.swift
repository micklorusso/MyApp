//
//  PokemonDetailManager.swift
//  MyApp
//
//  Created by Lorusso, Michele on 26/11/24.
//

import Combine
import Foundation

class PokemonDetailManager {

    let pokemonDetailService = PokemonDetailService()
    private var _pokemonDetail: PokemonDetailModel?
    var pokemonDetail: PokemonDetailModel? {
        get {
            return _pokemonDetail
        }
        set {
            isLoading = false
            _pokemonDetail = newValue
        }
    }

    @Published var isLoading = false

    init(id: Int) {
        guard !isLoading else { return }
        isLoading = true
        Task {
            //sleep(2)
            await pokemonDetailService.fetchData(with: id)
        }
    }

}
