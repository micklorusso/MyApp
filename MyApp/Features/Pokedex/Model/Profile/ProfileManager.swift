//
//  ProfileManager.swift
//  MyApp
//
//  Created by Lorusso, Michele on 30/11/24.
//

import Foundation
import UIKit

class ProfileManager {
    private var profile: UserProfile = UserProfile(
        name: "", lastName: "", dateOfBirth: "", profileImagePath: nil)
    {
        didSet {
            if profile != oldValue {
                print("Profile Updated")
                saveProfile()
            }
        }
    }

    init() {
        loadProfile()
    }
    
    //getters
    func getProfile() -> UserProfile{
        return profile
    }
    
    func getProfileImage() -> UIImage {
        if let profileImagePath = profile.profileImagePath,
           FileManager.default.fileExists(atPath: profileImagePath) {
            return UIImage(contentsOfFile: profileImagePath) ?? UIImage(named: Constants.Assets.profilePlaceholder)!
        } else {
            return UIImage(named: Constants.Assets.profilePlaceholder)!
        }
    }
    
    //setters
    func changeProfileName(name: String){
        profile.name =  name
    }
    
    func changeProfileLastName(lastName: String){
        profile.lastName = lastName
    }
    
    func changeProfileDateOfBirth(dateOfBirth: String){
        profile.dateOfBirth = dateOfBirth
    }

    func changeProfileImage(imageURL: URL) {
        let fileManager = FileManager.default
        if let documentsDirectory = fileManager.urls(
            for: .documentDirectory, in: .userDomainMask
        ).first {
            do {
                let contents = try fileManager.contentsOfDirectory(
                    at: documentsDirectory, includingPropertiesForKeys: nil)
                for file in contents {
                    if file.lastPathComponent.hasPrefix(
                        Constants.LocalStorage.profileImageName)
                    {
                        try fileManager.removeItem(at: file)
                        print(
                            "Old profile image removed: \(file.lastPathComponent)"
                        )
                    }
                }
            } catch {
                print("Failed to remove old profile image: \(error)")
            }

            let fileExtension = imageURL.pathExtension
            let destinationURL = documentsDirectory.appendingPathComponent(
                "\(Constants.LocalStorage.profileImageName).\(fileExtension)")

            do {
                try fileManager.copyItem(at: imageURL, to: destinationURL)
                print("New profile image saved to: \(destinationURL.path)")
                profile.profileImagePath = destinationURL.path
            } catch {
                print("Failed to save the new image: \(error)")
            }
        } else {
            print("No URL found for the selected image.")
        }
    }

    //private methods
    private func saveProfile() {
        do {
            let jsonData = try JSONEncoder().encode(profile)
            KeychainHelper.shared.save(
                data: jsonData, forKey: Constants.LocalStorage.userProfile)
        } catch {
            print("Failed to encode profile: \(error)")
        }
    }

    private func loadProfile() {
        guard
            let jsonData = KeychainHelper.shared.retrieveData(
                forKey: Constants.LocalStorage.userProfile)
        else {
            print("No profile data found in Keychain.")
            return
        }

        do {
            profile = try JSONDecoder().decode(UserProfile.self, from: jsonData)
        } catch {
            print("Failed to decode profile: \(error)")
        }
    }
}
