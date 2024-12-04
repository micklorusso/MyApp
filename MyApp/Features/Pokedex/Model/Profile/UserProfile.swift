//
//  UserProfile.swift
//  MyApp
//
//  Created by Lorusso, Michele on 30/11/24.
//

import Foundation
import UIKit

struct UserProfile: Codable, Equatable {
    var name: String
    var lastName: String
    var dateOfBirth: String
    var profileImagePath: String?

    init(
        name: String, lastName: String, dateOfBirth: String,
        profileImagePath: String?
    ) {
        self.name = name
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.profileImagePath = profileImagePath
    }

    static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.name == rhs.name && lhs.lastName == rhs.lastName
            && lhs.dateOfBirth == rhs.dateOfBirth
            && lhs.profileImagePath == rhs.profileImagePath
    }
}
