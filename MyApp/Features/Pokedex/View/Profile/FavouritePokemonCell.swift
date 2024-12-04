//
//  FavouritePokemonCell.swift
//  MyApp
//
//  Created by Lorusso, Michele on 02/12/24.
//

import UIKit

class FavouritePokemonCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var pokemonImageView: UIImageView!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(pokemon: PokemonListModel) {
        nameLabel.text = pokemon.name
        nameLabel.font = AppFonts.pokemonFontHollow(ofSize: 20)
        Util.loadImage(imageStr: pokemon.image, in: pokemonImageView)
    }
}
