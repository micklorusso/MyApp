//
//  ProfileViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 29/11/24.
//

import UIKit

class ProfileViewController: UIViewController {

    lazy var contentView = ProfileView()
    let profileManager = ProfileManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.delegate = self
        contentView.setProfileImage(profileManager.getProfileImage())
        contentView.configureProfile(with: profileManager.getProfile())
        view = contentView

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
