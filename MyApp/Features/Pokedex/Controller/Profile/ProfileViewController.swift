//
//  ProfileViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 29/11/24.
//

import UIKit

class ProfileViewController: UIViewController {

    lazy var contentView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.delegate = self
        contentView.configureProfile(
            image: UIImage(named: Constants.Assets.profilePlaceholder),
            firstName: "Michele", lastName: "Lorusso", birthDate: "31/01/2003")
        view = contentView

    }

}

extension ProfileViewController: ProfileViewDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func didTapProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary

        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                contentView.setProfileImage(selectedImage)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }

}
