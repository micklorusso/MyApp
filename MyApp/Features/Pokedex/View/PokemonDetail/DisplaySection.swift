//
//  DisplaySection.swift
//  MyApp
//
//  Created by Lorusso, Michele on 26/11/24.
//
import UIKit

protocol DisplaySectionDelegate {
    func favouriteButtonTapped()
}

public class DisplaySection: UIView {
    var delegate: DisplaySectionDelegate?

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var typesStackView: UIStackView!

    @IBOutlet weak var pokemonImageView: UIImageView!

    @IBOutlet weak var idLabel: UILabel!

    @IBOutlet weak var favouriteButton: UIButton!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewInit()
    }

    func configure(pokemon: PokemonDetailModel) {
        contentView.backgroundColor =
            UIConstants.PokemonDetail.defaultBackgroundColor
        if let color = pokemon.color {
            self.animateBackgroundColor(color: color)
        }
        nameLabel.text = pokemon.name
        nameLabel.font = AppFonts.pokemonFontSolid(ofSize: 30)
        Util.loadImage(imageStr: pokemon.image, in: pokemonImageView)
        Util.loadTypes(
            types: pokemon.types, in: typesStackView, labelColor: .white,
            font: AppFonts.pokemonFontSolid(ofSize: 20))
        if let pokemonID = pokemon.id {
            idLabel.text = "#\(String(format: "%03d", pokemonID))"
            idLabel.font = AppFonts.pokemonFontSolid(ofSize: 20)
            toggleFavouriteIcon(
                isFavourite: FavouritesManager.shared.isFavourite(
                    pokemonID: pokemonID))
        }
    }

    func animateBackgroundColor(color: UIColor) {
        UIView.animate(
            withDuration: UIConstants.PokemonDetail.animationDuration,
            delay: 0,
            options: [.curveEaseInOut]
        ) {
            self.contentView.backgroundColor = color
        }
    }

    @IBAction func favouriteButtonTapped(_ sender: UIButton) {
        delegate?.favouriteButtonTapped()
    }

    func toggleFavouriteIcon(isFavourite: Bool) {
        favouriteButton.setImage(
            UIImage(systemName: isFavourite ? "heart.fill" : "heart"),
            for: .normal)
    }
}
