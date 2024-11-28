//
//  DisplaySection.swift
//  MyApp
//
//  Created by Lorusso, Michele on 26/11/24.
//

import UIKit

@IBDesignable class DisplaySectionWrapper : NibWrapperView<DisplaySection> { }

class DisplaySection: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var typesStackView: UIStackView!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    
    func configure(pokemon: PokemonDetailModel){
        self.nameLabel.text = pokemon.name
        self.idLabel.text = pokemon.id
        Util.loadImage(imageStr: pokemon.image, in: pokemonImage)
        Util.loadTypes(types: pokemon.types, in: typesStackView, labelColor: .white)
        //contentView.backgroundColor = pokemon.color
    }
}
