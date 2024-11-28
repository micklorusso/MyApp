//
//  DisplaySection.swift
//  MyApp
//
//  Created by Lorusso, Michele on 26/11/24.
//
import UIKit

public class DisplaySection: UIView {
    
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var typesStackView: UIStackView!
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewInit()
    }
    
    func configure(pokemon: PokemonDetailModel){
        contentView.backgroundColor = pokemon.color
        nameLabel.text = pokemon.name
        idLabel.text = pokemon.id
        Util.loadImage(imageStr: pokemon.image, in: pokemonImageView)
        Util.loadTypes(types: pokemon.types, in: typesStackView, labelColor: .white)
    }
}


