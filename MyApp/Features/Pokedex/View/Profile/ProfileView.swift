//
//  ProfileView.swift
//  MyApp
//
//  Created by Lorusso, Michele on 29/11/24.
//

import UIKit

protocol ProfileViewDelegate {
    func didTapProfileImage()
}

class ProfileView: UIView {

    var delegate: ProfileViewDelegate?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        return imageView
    }()

    func setProfileImage(_ image: UIImage) {
        profileImageView.image = image
    }

    private func setupProfileImageView() {
        let tapGesture = UITapGestureRecognizer(
            target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
    }

    @objc private func profileImageTapped() {
        delegate?.didTapProfileImage()
    }

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "First Name".localized()
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Last Name".localized()
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let birthdateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Date of Birth".localized()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        setupDelegates()
        setupProfileImageView()

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(profileImageView)
        contentView.addSubview(nameTextField)
        contentView.addSubview(surnameTextField)
        contentView.addSubview(birthdateTextField)

        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Profile Image
            profileImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            // Name TextField
            nameTextField.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -20),

            // Surname TextField
            surnameTextField.topAnchor.constraint(
                equalTo: nameTextField.bottomAnchor, constant: 10),
            surnameTextField.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 20),
            surnameTextField.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -20),

            // Birthdate TextField
            birthdateTextField.topAnchor.constraint(
                equalTo: surnameTextField.bottomAnchor, constant: 10),
            birthdateTextField.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 20),
            birthdateTextField.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -20),
            birthdateTextField.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -40),
        ])
    }

    func configureProfile(
        image: UIImage?, firstName: String, lastName: String, birthDate: String
    ) {
        profileImageView.image = image
        nameTextField.text = firstName
        surnameTextField.text = lastName
        birthdateTextField.text = birthDate
    }
}

extension ProfileView: UITextFieldDelegate {
    func setupDelegates() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        birthdateTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            textField.placeholder = "Write something here"
            return false
        } else {
            return true
        }
    }
}

extension ProfileView: UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{

}
