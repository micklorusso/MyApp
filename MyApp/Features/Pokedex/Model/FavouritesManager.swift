//
//  FavouritesManager.swift
//  MyApp
//
//  Created by Lorusso, Michele on 02/12/24.
//

import Foundation

class FavouritesManager {
    static let shared = FavouritesManager()

    @Published var favourites: Set<Int> = []

    init() {
        loadFavourites()
    }

    func isFavourite(pokemonID: Int) -> Bool {
        return favourites.contains(pokemonID)
    }

    func toggleFavourite(pokemonID: Int) {
        if isFavourite(pokemonID: pokemonID) {
            removeFavourite(pokemonID: pokemonID)
        } else {
            addFavourite(pokemonID: pokemonID)
        }
    }

    private func addFavourite(pokemonID: Int) {
        favourites.insert(pokemonID)
        saveFavourites()
    }

    private func removeFavourite(pokemonID: Int) {
        favourites.remove(pokemonID)
        saveFavourites()
    }

    private func saveFavourites() {
        UserDefaults.standard.set(
            Array(favourites), forKey: Constants.LocalStorage.favouritesKey)
    }

    private func loadFavourites() {
        if let savedFavourites = UserDefaults.standard.array(
            forKey: Constants.LocalStorage.favouritesKey) as? [Int]
        {
            favourites = Set(savedFavourites)
        }
    }
    
}
