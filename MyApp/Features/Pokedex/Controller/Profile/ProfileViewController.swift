//
//  ProfileViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 29/11/24.
//

import Combine
import UIKit

class ProfileViewController: UIViewController {

    lazy var contentView = ProfileView()
    let profileManager = ProfileManager()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.favouritesCollectionView.dataSource = self
        profileManager.favouritesService.delegate = self

        FavouritesManager.shared.$favourites
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.global(qos: .userInitiated))
            .sink { [weak self] _ in
                self?.profileManager.loadFavourites()
            }
            .store(in: &cancellables)

        profileManager.$isLoading
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.contentView.activityIndicator.startAnimating()
                } else {
                    self?.contentView.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)

        contentView.delegate = self
        contentView.setProfileImage(profileManager.getProfileImage())
        contentView.configureProfile(with: profileManager.getProfile())
        view = contentView

        profileManager.loadFavourites()

    }

}

extension ProfileViewController: ProfileViewDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func didUpdateField(fieldType: ProfileFieldType, value: String) {
        switch fieldType {
        case .name:
            profileManager.changeProfileName(name: value)
        case .lastName:
            profileManager.changeProfileLastName(lastName: value)
        case .dateOfBirth:
            profileManager.changeProfileDateOfBirth(dateOfBirth: value)
        }
    }

    func didTapProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary

        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:
            Any]
    ) {
        if let imageURL = info[.imageURL] as? URL {
            profileManager.changeProfileImage(imageURL: imageURL)
            contentView.setProfileImage(profileManager.getProfileImage())
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        return profileManager.favouritePokemon.count
    }

    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: Files.Cells
                    .favouritePokemonCellIdentifier, for: indexPath)
            as! FavouritePokemonCell
        cell.configure(pokemon: profileManager.favouritePokemon[indexPath.row])
        return cell
    }
}

extension ProfileViewController: FavouritesServiceDelegate {
    func didUpdatePokemonFavourites(
        _ pokemonApi: PokemonApi, pokemon: [PokemonListModel]
    ) {
        profileManager.addFavourites(pokemon)
        DispatchQueue.main.async {
            if pokemon.count == 1 {
                self.contentView.changeColumns(to: 1)
            } else {
                self.contentView.changeColumns(to: 2)
            }
            self.contentView.setFavouriteLabelText(
                numberOfPokemon: pokemon.count)

            self.contentView.favouritesCollectionView.reloadData()
        }
    }

    func didFailWithError(_ error: any Error) {
        print(error)
    }

}
