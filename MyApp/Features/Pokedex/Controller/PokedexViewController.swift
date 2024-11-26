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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
