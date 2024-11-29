//
//  ViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

import UIKit

class PokedexViewController: UIViewController {
    let pokedexManger = PokedexManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    enum TabBarItems: Int {
        case pokedex = 0
        case settings = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabBarItems = self.tabBarController?.tabBar.items{
            tabBarItems[TabBarItems.pokedex.rawValue].title = "Pokedex"
            tabBarItems[TabBarItems.settings.rawValue].title = "Settings".localized()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.Cells.pokemonCellNibName, bundle: nil), forCellReuseIdentifier: Constants.Cells.pokemonCellIdentifier)
        
        pokedexManger.pokemonListService.delegate = self
        pokedexManger.loadPokemon()
    }
    
}

extension PokedexViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedexManger.getPokedexCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon = pokedexManger.getPokemon(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.pokemonCellIdentifier, for: indexPath) as! PokemonCell
        cell.configure(with: pokemon)
        return cell
    }
}

extension PokedexViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pokedexManger.getPokedexCount() - 1 {
            pokedexManger.loadPokemon()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segue.pokedexToDetail, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PokemonDetailViewController
        destinationVC.hidesBottomBarWhenPushed = true
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.pokemonID = pokedexManger.getPokemon(at: indexPath.row).id
        }
    }
}

extension PokedexViewController: PokemonListDelegate{
    func didUpdatePokemonList(_ pokemonApi: PokemonApi, pokemon: [PokemonListModel]) {
        DispatchQueue.main.async{
            self.pokedexManger.addPokemon(pokemon)
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: any Error) {
        print("Error fetching data \(error)")
    }
    
    
}
