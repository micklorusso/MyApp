//
//  PokemonDetailModel.swift
//  MyApp
//
//  Created by Lorusso, Michele on 25/11/24.
//

import UIKit

struct PokemonDetailModel{
    let name: String?
    var types: [String] = []
    let image: String?
    let id: Int?
    var species: String?
    let height: String?
    let weight: String?
    var abilities: [String] = []
    let gender: Gender?
    var eggGroups: [String] = []
    var stats: [Stathistic] = []
    var color: UIColor?
    
    init(pokemonDetail: PokemonDetail, pokemonSpecies: PokemonSpecies){
        self.name = pokemonDetail.name
        self.image = pokemonDetail.sprites?.other.officialArtwork.front_default
        if let pokemonTypes = pokemonDetail.types{
            for pokemonType in pokemonTypes{
                types.append(pokemonType.type.name)
            }
        }
        self.id = pokemonDetail.id
        
        for species in pokemonSpecies.genera{
            if species.language.name == "en"{
                self.species = species.genus
            }
        }
        
        if let height = pokemonDetail.height {
            self.height = "\(String(format: "%.2f" , Float(height) * 10.0)) cm"
        } else{
            self.height = nil
        }
        
        if let weight = pokemonDetail.weight{
            self.weight = "\(String(format: "%.1f" , Float(weight) / 10.0)) kg"
        } else{
            self.weight = nil
        }

        if let pokemonAbilities = pokemonDetail.abilities{
            for ability in pokemonAbilities{
                abilities.append(ability.ability.name)
            }
        }

        
        if pokemonSpecies.gender_rate == -1 {
            gender = nil
        } else {
            let femalePercentage = (Float(pokemonSpecies.gender_rate) / 8.0) * 100.0
            let malePercentage = 100.0 - femalePercentage
            let malePercentageString = "\(String(format: "%.1f", malePercentage))%"
            let femalePercentageString = "\(String(format: "%.1f", femalePercentage))%"
            gender = Gender(malePercentage: malePercentageString, femalePercentage: femalePercentageString)
        }
        
        for eggGroup in pokemonSpecies.egg_groups{
            eggGroups.append(eggGroup.name)
        }
        
        var total = 0
        if let pokemonStats =  pokemonDetail.stats{
            for stat in pokemonStats{
                stats.append(Stathistic(name: stat.stat.name, value: stat.base_stat, valueFloat: Float(stat.base_stat) / 100.0))
                total += stat.base_stat
            }
            stats.append(Stathistic(name: "total", value: total, valueFloat: Float(total) / Float(stats.count * 100)))
        }
        
        self.color = Constants.pokedexColorMap[pokemonSpecies.color.name]
    
    }
}


struct Gender{
    let malePercentage: String
    let femalePercentage: String
}

struct Stathistic{
    let name: String
    let value: Int
    var valueFloat: Float
}
