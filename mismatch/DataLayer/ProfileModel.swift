//
//  ProfileModel.swift
//  mismatch
//
//  Created by Kunal Kamble on 10/01/25.
//

import SwiftData
import SwiftUI

@Model
class ProfileModel {
    private(set) var id: String

    private(set) var firstName: String
    private(set) var lastName: String

    private(set) var streetNumber: String
    private(set) var streetName: String
    private(set) var city: String

    private(set) var age: String

    private(set) var profileImageURLString: String

    private(set) var liked: Bool = false
    private(set) var shortlisted: Bool = false

    init(id: String,
         firstName: String, lastName: String,
         streetNumber: String, streetName: String, city: String,
         age: String,
         liked: Bool = false, shortlisted: Bool = false,
         profileImageURLString: String)
    {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.streetNumber = streetNumber
        self.streetName = streetName
        self.city = city
        self.age = age
        self.liked = liked
        self.shortlisted = shortlisted
        self.profileImageURLString = profileImageURLString
    }
}

extension ProfileModel: Identifiable {}

// MARK: - Update property locally

extension ProfileModel {
    func toggleLikeOnModelLevel() {
        liked = !liked
        if liked {
            shortlisted = false
        }
    }

    func toggleShortlistOnModelLevel() {
        shortlisted = !shortlisted
        if shortlisted {
            liked = false
        }
    }
}

// MARK: - View Data

extension ProfileModel {
    var displayName: String {
        // TODO: This is is not i18n supported
        "\(firstName) \(lastName), \(age)"
    }

    var displayLocation: String {
        // TODO: This is is not i18n supported
        "\(streetNumber) \(streetName), \(city)"
    }
}
