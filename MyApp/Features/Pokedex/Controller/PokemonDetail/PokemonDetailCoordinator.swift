//
//  PokemonDetailCoordinator.swift
//  MyApp
//
//  Created by Lorusso, Michele on 08/12/24.
//

import UIKit

class PokemonDetailCoordinator: Coordinator, PokemonDetailNavigation {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: PokedexCoordinator?
    var pokemonID: Int
    
    func didDismissScreen() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func start() {
        let vc = PokemonDetailViewController.instantiate(storyboardName: "PokemonDetail")
        vc.coordinator = self
        vc.pokemonID = self.pokemonID
        navigationController.pushViewController(vc, animated: true)
    }
    
    init(navigationController: UINavigationController, pokemonID: Int){
        self.navigationController = navigationController
        self.pokemonID = pokemonID
    }
    
}
