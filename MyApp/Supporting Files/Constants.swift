//
//  Constants.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//
import UIKit

struct Constants{
    static let pokemonPerPage = 10
    static let apiURL = "https://pokeapi.co/api/v2/"
    struct Routes{
        static let pokemonList = "pokemon?limit=\(pokemonPerPage)&offset="
        static let pokemonSpecies = "pokemon-species/"
        static let pokemonDetail = "pokemon/"
        
    }
    struct Cells{
        static let pokemonCellIdentifier = "ReusablePokemonCell"
        static let pokemonCellNibName = "PokemonCell"
    }
    
    struct Segue{
        static let pokedexToDetail = "PokedexToDetail"
    }
    struct LocalStorage{
        static let userProfile = "UserProfile"
        static let profileImageName = "profileImage"
    }
    
    static let pokedexColorMap =  [
        "red": UIColor.red,
        "blue": UIColor.blue,
        "yellow": UIColor.yellow,
        "green": UIColor.green,
        "black": UIColor.black,
        "brown": UIColor.brown,
        "purple": UIColor.purple,
        "gray": UIColor.gray,
        "white": UIColor.white,
        "pink": UIColor.systemPink
    ]
    
    static let localizedStringsTable = "Localizable"
    
    struct Language{
        static let languageKey = "AppLanguage"
        static let defaultLanguage = "en"
    }
    
    enum TabBarItems: Int {
        case pokedex = 0
        case settings = 1
        case profile = 2
    }
    
    struct Assets{
        static let profilePlaceholder = "ProfilePlaceholder"
    }
}
