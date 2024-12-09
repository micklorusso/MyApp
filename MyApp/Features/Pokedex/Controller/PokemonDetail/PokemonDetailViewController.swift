//
//  PokemonDetailViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 27/11/24.
//

import Combine
import UIKit

protocol PokemonDetailNavigation: AnyObject {
    func didDismissScreen()
}

class PokemonDetailViewController: UIViewController, Storyboarded {
    weak var coordinator: PokemonDetailNavigation?
    var pokemonID: Int?
    var pokemonDetailManager: PokemonDetailManager?

    @IBOutlet weak var displaySection: DisplaySection!
    @IBOutlet weak var aboutSection: AboutSection!
    @IBOutlet weak var baseStatsSection: BaseStatsSection!

    @IBOutlet weak var tabSegmentedControl: UISegmentedControl!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var cancellables: Set<AnyCancellable> = []

    enum Section: Int {
        case about = 0
        case baseStats = 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tabSegmentedControl.setTitle(
            "About".localized(), forSegmentAt: Section.about.rawValue)
        tabSegmentedControl.setTitle(
            "Base Stats".localized(), forSegmentAt: Section.baseStats.rawValue)

        if let id = pokemonID {
            pokemonDetailManager = PokemonDetailManager(id: id)
            pokemonDetailManager!.pokemonDetailService.delegate = self
            displaySection.delegate = self
            tabSegmentedControl.selectedSegmentIndex = 0
            tabChanged(tabSegmentedControl)
        }

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
        ])

        if let manager = pokemonDetailManager {
            manager.$isLoading
                .subscribe(on: DispatchQueue.global(qos: .userInitiated))
                .receive(on: DispatchQueue.main)
                .sink { [weak self] isLoading in
                    if isLoading {
                        self?.activityIndicator.startAnimating()
                        self?.view.subviews.forEach { subview in
                            if subview != self?.activityIndicator {
                                subview.isHidden = true
                            }
                        }
                    } else {
                        self?.activityIndicator.stopAnimating()
                        self?.view.subviews.forEach { subview in
                            if subview != self?.activityIndicator {
                                subview.isHidden = false
                            }
                        }
                    }
                }
                .store(in: &cancellables)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        coordinator?.didDismissScreen()
    }

    @IBAction func tabChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case Section.about.rawValue:
            baseStatsSection.isHidden = true
            aboutSection.isHidden = false
        case Section.baseStats.rawValue:
            aboutSection.isHidden = true
            baseStatsSection.isHidden = false
        default:
            break
        }
    }
}

extension PokemonDetailViewController: PokemonDetailServiceDelegate {
    func didUpdatePokemonDetail(
        _ pokemonApi: PokemonDetailService, pokemon: PokemonDetailModel
    ) {
        pokemonDetailManager?.pokemonDetail = pokemon

        DispatchQueue.main.async {
            self.displaySection.configure(pokemon: pokemon)
            self.aboutSection.configure(pokemon: pokemon)
            self.baseStatsSection.configure(pokemon: pokemon)
        }
    }

    func didFailWithError(_ error: any Error) {
        print(error)
    }

}

extension PokemonDetailViewController: DisplaySectionDelegate {
    func favouriteButtonTapped() {
        if let pokemonID = pokemonDetailManager?.pokemonDetail?.id {
            FavouritesManager.shared.toggleFavourite(pokemonID: pokemonID)
            displaySection.toggleFavouriteIcon(
                isFavourite: FavouritesManager.shared.isFavourite(
                    pokemonID: pokemonID))
        }
    }
}
