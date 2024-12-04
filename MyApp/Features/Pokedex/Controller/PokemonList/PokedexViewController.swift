//
//  ViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 22/11/24.
//

import Combine
import UIKit

class PokedexViewController: UIViewController {
    let pokedexManager = PokedexManager()
    private var cancellables: Set<AnyCancellable> = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: Files.Cells.pokemonCellNibName, bundle: nil),
            forCellReuseIdentifier: Files.Cells.pokemonCellIdentifier)

        pokedexManager.pokemonListService.delegate = self
        pokedexManager.loadPokemon()

        FavouritesManager.shared.$favourites
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        pokedexManager.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.setupTableFooter()
                } else {
                    self?.removeTableFooter()
                }
            }
            .store(in: &cancellables)

    }

    func setupTableFooter() {
        let footerView = UIView(
            frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        activityIndicator.center = footerView.center
        footerView.addSubview(activityIndicator)
        tableView.tableFooterView = footerView
        activityIndicator.startAnimating()
    }

    func removeTableFooter() {
        tableView.tableFooterView = nil
    }

}

extension PokedexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return pokedexManager.getPokedexCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let pokemon = pokedexManager.getPokemon(at: indexPath.row)
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: Files.Cells.pokemonCellIdentifier,
                for: indexPath) as! PokemonCell
        cell.configure(with: pokemon)
        if let pokemonID = pokemon.id {
            cell.favouriteButton.isHidden = !FavouritesManager.shared
                .isFavourite(pokemonID: pokemonID)
        }
        return cell
    }
}

extension PokedexViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView, willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if indexPath.row == pokedexManager.getPokedexCount() - 1 {
            pokedexManager.loadPokemon()
        }
    }

    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        performSegue(withIdentifier: Routes.Local.pokedexToDetail, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PokemonDetailViewController
        destinationVC.hidesBottomBarWhenPushed = true
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.pokemonID =
                pokedexManager.getPokemon(at: indexPath.row).id
        }
    }
}

extension PokedexViewController: PokemonListServiceDelegate {
    func didUpdatePokemonList(
        _ pokemonApi: PokemonApi, pokemon: [PokemonListModel]
    ) {
        self.pokedexManager.addPokemon(pokemon)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func didFailWithError(_ error: any Error) {
        print("Error fetching data \(error)")
    }

}
