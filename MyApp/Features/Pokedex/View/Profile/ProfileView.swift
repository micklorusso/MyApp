//
//  ProfileView.swift
//  MyApp
//
//  Created by Lorusso, Michele on 29/11/24.
//

import UIKit

protocol ProfileViewDelegate {
    func didTapProfileImage()
    func didUpdateField(fieldType: ProfileFieldType, value: String)
}

enum ProfileFieldType {
    case name
    case lastName
    case dateOfBirth
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
    
    private let favouritesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    func setFavouriteLabelText(numberOfPokemon: Int){
        if numberOfPokemon > 0{
            favouritesLabel.font = UIFont.boldSystemFont(ofSize: 30)
            favouritesLabel.text = "Favourites"
        } else{
            favouritesLabel.font = UIFont.systemFont(ofSize: 30)
            favouritesLabel.text = "You don't have any favourite pokemon yet"
        }
    }

    let favouritesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        var collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(
            UINib(nibName: Constants.Cells.favouritePokemonCellNibName, bundle: nil),
            forCellWithReuseIdentifier: Constants.Cells.favouritePokemonCellIdentifier)

        return collectionView
    }()
    
    func changeColumns(to numberOfColumns: Int) {
        guard let layout = favouritesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let spacing: CGFloat = 8
        let totalSpacing = spacing * CGFloat(numberOfColumns - 1)
        let availableWidth = favouritesCollectionView.bounds.width - totalSpacing
        let itemWidth = availableWidth / CGFloat(numberOfColumns)

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.invalidateLayout()
    }

    private let datePicker = UIDatePicker()

    private func setupDatePicker() {
        datePicker.locale = Locale(
            identifier: LanguageManager.getCurrentLanguageCode())
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        datePicker.addTarget(
            self, action: #selector(datePickerChanged(_:)), for: .valueChanged)

        birthdateTextField.inputView = datePicker

        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done, target: self,
            action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: true)
        birthdateTextField.inputAccessoryView = toolbar
    }

    @objc private func datePickerChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        birthdateTextField.text = formatter.string(from: sender.date)
    }

    @objc private func doneButtonTapped() {
        birthdateTextField.resignFirstResponder()
    }

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
        setupDatePicker()
        setupProfileImageView()

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(profileImageView)
        contentView.addSubview(nameTextField)
        contentView.addSubview(surnameTextField)
        contentView.addSubview(birthdateTextField)
        contentView.addSubview(favouritesLabel)
        contentView.addSubview(favouritesCollectionView)

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
            
            // Favourites Label
            favouritesLabel.topAnchor.constraint(equalTo: birthdateTextField.bottomAnchor, constant: 20),
            favouritesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            favouritesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Favourites CollectionView
            favouritesCollectionView.topAnchor.constraint(equalTo: favouritesLabel.bottomAnchor, constant: 10),
            favouritesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            favouritesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            favouritesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favouritesCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }

    func configureProfile(
        with profile: UserProfile
    ) {
        nameTextField.text = profile.name
        surnameTextField.text = profile.lastName
        birthdateTextField.text = profile.dateOfBirth
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

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            delegate?.didUpdateField(
                fieldType: .name, value: textField.text ?? "")
        case surnameTextField:
            delegate?.didUpdateField(
                fieldType: .lastName, value: textField.text ?? "")
        case birthdateTextField:
            delegate?.didUpdateField(
                fieldType: .dateOfBirth, value: textField.text ?? "")
        default:
            print(
                "Text field ended editing but the corresponding didUpdateField was not called, add it to the switch in textFieldDidEndEditing"
            )
        }
    }
}

