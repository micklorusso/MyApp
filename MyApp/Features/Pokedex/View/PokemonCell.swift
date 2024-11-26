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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with pokemon: PokemonListModel){
        pokemonNameLabel.text = pokemon.name
        if let image = pokemon.image{
            if let imageUrl = URL(string: image) {
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.pokemonImageView.image = image
                        }
                    } else {
                        print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }.resume()
            } else {
                print("Invalid URL")
            }
        }
        let currentTypes = typesStackView.arrangedSubviews.compactMap { ($0 as? UILabel)?.text }
        if currentTypes != pokemon.types {
               typesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            for type in pokemon.types {
                   let typeLabel = UILabel()
                   typeLabel.text = type
                   typeLabel.font = UIFont.systemFont(ofSize: 14)
                   typeLabel.textColor = .darkGray
                   typesStackView.addArrangedSubview(typeLabel)
               }
           }
    }
    

    
}
