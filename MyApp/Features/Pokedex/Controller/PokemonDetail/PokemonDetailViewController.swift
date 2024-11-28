//
//  PokemonDetailViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 27/11/24.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    
    var pokemonID: Int?
    var pokemonDetailManager: PokemonDetailManager?


    @IBOutlet weak var displaySection: UIView!
    
    
    
    @IBOutlet weak var aboutSection: AboutSection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = pokemonID{
            pokemonDetailManager = PokemonDetailManager(id: id)
            pokemonDetailManager!.pokemonDetailService.delegate = self
        }

    }
    
}


extension PokemonDetailViewController: PokemonDetailDelegate {
    func didUpdatePokemonDetail(_ pokemonApi: PokemonDetailService, pokemon: PokemonDetailModel) {
        pokemonDetailManager?.pokemonDetail = pokemon
        
        DispatchQueue.main.async{
            (self.displaySection as? DisplaySectionWrapper)?.contentView.configure(pokemon: pokemon)
            //self.aboutSection.configure(pokemon: pokemon)
        }
    }
    
    func didFailWithError(_ error: any Error) {
        print(error)
    }

}
