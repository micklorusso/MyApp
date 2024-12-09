//
//  PokedexManager.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

import Combine

class PokedexManager {
    var pokedex: [PokemonListModel] = []
    let pokemonListService = PokemonListService()
    let audinoService = FavouritesService()

    @Published var isLoading = false
    private var currentPage = 0
    private var currentPageItemCount = 0
    private var hasMoreData = true
    
    
    init(){
        loadAudino()
    }

    func addPokemon(_ pokemon: [PokemonListModel]) {
        isLoading = false

        pokedex.append(contentsOf: pokemon)
        pokedex.sort {
            if let firstItemPos = $0.order, let secondItemPos = $1.order {
                if firstItemPos == 646 {
                    return true
                } else if secondItemPos == 646 {
                    return false
                } else {
                    return firstItemPos < secondItemPos
                }
            } else {
                return false
            }
        }
        self.currentPage += 1
        self.hasMoreData = pokemon.count == Routes.API.pokemonPerPage
    }

    func getPokedexCount() -> Int {
        return pokedex.count
    }

    func getPokemon(at index: Int) -> PokemonListModel {
        return pokedex[index]
    }

    func loadPokemon() {
        guard !isLoading && hasMoreData else { return }
        isLoading = true

        Task {
            await pokemonListService.fetchData(
                offset: currentPage * Routes.API.pokemonPerPage)
        }
    }
    
    func loadAudino(){
        Task {
            await audinoService.fetchData(forIds: [531])
        }
    }

}
