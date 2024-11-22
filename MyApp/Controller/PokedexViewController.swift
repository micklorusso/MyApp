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
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.Cells.pokemonCellNibName, bundle: nil), forCellReuseIdentifier: K.Cells.pokemonCellIdentifier)
        
        pokedexManger.pokemonApi.delegate = self

    }
    
}

extension PokedexViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedexManger.getPokedexCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon = pokedexManger.getPokemon(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.pokemonCellIdentifier, for: indexPath) as! PokemonCell
        cell.configure(with: pokemon)
        return cell
    }
}

extension PokedexViewController: PokemonApiDelegate{
    func didUpdatePokemon(_ pokemonApi: PokemonApi, pokemon: PokemonModel) {
        pokedexManger.addPokemon(pokemon)
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: any Error) {
        print("Error fetching data \(error)")
    }
    
    
}
