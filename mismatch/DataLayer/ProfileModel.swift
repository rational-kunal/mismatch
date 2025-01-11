//
//  ProfileModel.swift
//  mismatch
//
//  Created by Kunal Kamble on 10/01/25.
//

import SwiftData

@Model
class ProfileModel {
    private(set) var id: String

    private(set) var firstName: String
    private(set) var lastName: String

    private(set) var streetNumber: String
    private(set) var streetName: String
    private(set) var city: String

    private(set) var profileImageURLString: String

    init(id: String,
         firstName: String, lastName: String,
         streetNumber: String, streetName: String, city: String,
         profileImageURLString: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.streetNumber = streetNumber
        self.streetName = streetName
        self.city = city
        self.profileImageURLString = profileImageURLString
    }
}

extension ProfileModel: Identifiable {
    
}

extension ProfileModel {
    var displayTitle: String {
        // TODO: This is is not i18n supported
        "\(firstName) \(lastName)"
    }

    var displaySubtitle: String {
        // TODO: This is is not i18n supported
        "\(streetNumber) \(streetName), \(city)"
    }
}
