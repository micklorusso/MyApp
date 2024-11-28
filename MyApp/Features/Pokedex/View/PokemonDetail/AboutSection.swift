//
//  PokemonInfo.swift
//  MyApp
//
//  Created by Lorusso, Michele on 27/11/24.
//

import UIKit

class AboutSection: UIView {

    @IBOutlet weak var speciesLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var femaleLabel: UILabel!
    
    @IBOutlet weak var maleLabel: UILabel!
    
    @IBOutlet weak var eggGroupsLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewInit()
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewInit()
    }
    
    func configure(pokemon: PokemonDetailModel){
        speciesLabel.text = pokemon.species
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        femaleLabel.text = pokemon.gender?.femalePercentage
        maleLabel.text = pokemon.gender?.malePercentage
        abilitiesLabel.text = pokemon.abilities.joined(separator: ", ")
        eggGroupsLabel.text = pokemon.eggGroups.joined(separator: ", ")
    }

}
