//
//  ViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

import UIKit
import Combine

class PokedexViewController: UIViewController {
    let pokedexManger = PokedexManager()
    private var cancellables: Set<AnyCancellable> = []
    
    @IBOutlet weak var tableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.Cells.pokemonCellNibName, bundle: nil), forCellReuseIdentifier: Constants.Cells.pokemonCellIdentifier)
        
        pokedexManger.pokemonListService.delegate = self
        pokedexManger.loadPokemon()
        
        FavouritesManager.shared.$favourites
                   .receive(on: DispatchQueue.main)
                   .sink { [weak self] _ in
                       self?.tableView.reloadData()
                   }
                   .store(in: &cancellables)
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
        if let pokemonID = pokemon.id{
            cell.favouriteButton.isHidden = !FavouritesManager.shared.isFavourite(pokemonID: pokemonID)
        }
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

extension PokedexViewController: PokemonListServiceDelegate{
    func didUpdatePokemonList(_ pokemonApi: PokemonApi, pokemon: [PokemonListModel]) {
        self.pokedexManger.addPokemon(pokemon)
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: any Error) {
        print("Error fetching data \(error)")
    }
    
    
}

