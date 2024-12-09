//
//  PokedexCoordinator.swift
//  MyApp
//
//  Created by Lorusso, Michele on 06/12/24.
//


import UIKit

class PokedexCoordinator: Coordinator {

    weak var parentCoordinator: TabBarCoordinator?
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        let vc = PokedexViewController.instantiate(storyboardName: "Pokedex")
        vc.didSelectPokemonRow = { [weak self] id in self?.didSelectPokemonRow(pokemonID: id)}
        vc.tabBarItem = UITabBarItem(title: "Pokedex", image: UIImage(systemName: "list.bullet"), tag: TabBarItems.pokedex.rawValue)
        navigationController.viewControllers = [vc]
    }
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func didSelectPokemonRow(pokemonID: Int) {
        let child = PokemonDetailCoordinator(navigationController: navigationController, pokemonID: pokemonID)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?){
        //print(childCoordinators)
        for (index, coordinator) in
                childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        //print(childCoordinators)
    }

}
