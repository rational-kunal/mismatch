import os
import SwiftData
import SwiftUI
import SwiftyJSON

fileprivate let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: ProfileModel.self)
)

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
    }

    func toggleShortlistOnModelLevel() {
        shortlisted = !shortlisted
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

    var shouldShowLikeButton: Bool {
        return !liked
    }
}


// MARK: - parsing

extension ProfileModel {
    static func parse(json data: JSON) -> ProfileModel? {
        guard let id = data["login"]["uuid"].string,
              let firstName = data["name"]["first"].string,
              let lastName = data["name"]["last"].string,
              let streetNumber = data["location"]["street"]["number"].number?.stringValue,
              let streetName = data["location"]["street"]["name"].string,
              let city = data["location"]["city"].string,
              let age = data["dob"]["age"].number?.stringValue,
              let profileImageURLString = data["picture"]["large"].string
        else {
            logger.error("Unable to parse profile data")
            return nil
        }

        return ProfileModel(
            id: id,
            firstName: firstName,
            lastName: lastName,
            streetNumber: streetNumber,
            streetName: streetName,
            city: city,
            age: age,
            profileImageURLString: profileImageURLString
        )
    }
}
