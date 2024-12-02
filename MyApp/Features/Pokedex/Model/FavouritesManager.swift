//
//  FavouritesManager.swift
//  MyApp
//
//  Created by Lorusso, Michele on 02/12/24.
//

import Foundation

class FavouritesManager {
    static let shared = FavouritesManager()

    @Published private(set) var favourites: Set<String> = []

    init() {
        loadFavourites()
    }

    func isFavourite(pokemonID: String) -> Bool {
        return favourites.contains(pokemonID)
    }

    func toggleFavourite(pokemonID: String) {
        if isFavourite(pokemonID: pokemonID) {
            removeFavourite(pokemonID: pokemonID)
        } else {
            addFavourite(pokemonID: pokemonID)
        }
    }

    private func addFavourite(pokemonID: String) {
        favourites.insert(pokemonID)
        saveFavourites()
    }

    private func removeFavourite(pokemonID: String) {
        favourites.remove(pokemonID)
        saveFavourites()
    }

    func getFavourites() -> [String] {
        return Array(favourites)
    }

    private func saveFavourites() {
        UserDefaults.standard.set(
            Array(favourites), forKey: Constants.LocalStorage.favouritesKey)
    }

    private func loadFavourites() {
        if let savedFavourites = UserDefaults.standard.array(
            forKey: Constants.LocalStorage.favouritesKey) as? [String]
        {
            favourites = Set(savedFavourites)
        }
    }
    
    static func convertID(pokemonID: Int?) -> String?{
        if let id = pokemonID{
            return "#\(String(format: "%03d", id))"
        }
        return nil
    }
}
