//
//  PokemonCell.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var pokemonNameLabel: UILabel!

    @IBOutlet weak var pokemonImageView: UIImageView!

    @IBOutlet weak var typesStackView: UIStackView!

    @IBOutlet weak var favouriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with pokemon: PokemonListModel) {
        pokemonNameLabel.text = pokemon.name
        pokemonNameLabel.font = AppFonts.pokemonFontHollow(ofSize: 20)
        Util.loadImage(imageStr: pokemon.image, in: pokemonImageView)
        Util.loadTypes(
            types: pokemon.types, in: typesStackView, labelColor: .black,
            font: AppFonts.pokemonFontHollow(ofSize: 14))
    }

}
