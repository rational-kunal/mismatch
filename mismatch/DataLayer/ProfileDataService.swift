//
//  ProfileDataService.swift
//  mismatch
//
//  Created by Kunal Kamble on 10/01/25.
//

import Alamofire
import os
import SwiftUI
import SwiftyJSON
import SwiftData

let PROFILE_API_URL = "https://randomuser.me/api/?results=10"

class ProfileDataService: ObservableObject {
    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: ProfileDataService.self)
    )

    static let shared = ProfileDataService()

    @Published var profileQueue: [ProfileModel] = []
    
    private init() {
        Task {
            // Load profiles from local data store first
            await loadProfilesFromDataStore()

            // If no profiles, fetch from the network
            if profileQueue.isEmpty {
                fetchMoreProfiles()
            }
        }
    }

    func fetchMoreProfiles() {
        guard profileQueue.isEmpty else {
            Self.logger.debug("Profile queue already contains profiles")
            return
        }

        Task { [weak self] in
            guard let self else { return }
            guard let profiles = await fetchProfilesFromNetwork() else {
                Self.logger.error("Error while fetching profiles")
                // TODO: Show toast
                return
            }
            
            // Filter profiles that are not alreay present
            let filteredProfiles = profiles.filter { model in
                self.profileQueue.contains(where: { $0.id == model.id }) == false
            }

            await self.saveToDataStore(newProfiles: filteredProfiles)

            self.profileQueue.append(contentsOf: filteredProfiles)
            self.objectWillChange.send() // Send notification that object has changed
        }
    }
}

// MARK: - SwiftData Persistence Methods

extension ProfileDataService {
    private func loadProfilesFromDataStore() async {
        
        let fetchDescriptor = FetchDescriptor<ProfileModel>()
        let profileModels = try? SwiftDataService.shared.modelExecutor.modelContext.fetch(fetchDescriptor)
        
        guard let profileModels else {
            Self.logger.error("No profiles in data store")
            return
        }
        
        await MainActor.run { [weak self] in
            guard let self else { return }
            
            self.profileQueue = profileModels
            Self.logger.debug("Loaded \(profileModels.count) profiles from data store")
        }
    }

    private func saveToDataStore(newProfiles: [ProfileModel]) async {
        for profile in newProfiles {
            await SwiftDataService.shared.modelContainer.mainContext.insert(profile)
        }
        
        do {
            try await SwiftDataService.shared.modelContainer.mainContext.save()
            Self.logger.debug("Saved \(newProfiles.count) profiles to the data store")
        } catch {
            Self.logger.error("Error saving profiles to data store: \(error)")
        }
    }
}

// MARK: - Network Fetch and JSON Parsing

extension ProfileDataService {
    private func fetchProfilesFromNetwork() async -> [ProfileModel]? {
        let data = try? await AF.request(PROFILE_API_URL).serializingData().value

        guard let data, let results = JSON(data)["results"].array else {
            Self.logger.error("Error while decoding profiles response")
            return nil
        }

        var profiles = [ProfileModel]()
        for profileResultJSON in results {
            guard let profileModel = parseProfilesData(json: profileResultJSON) else {
                continue
            }

            profiles.append(profileModel)
        }

        return profiles
    }

    private func parseProfilesData(json data: JSON) -> ProfileModel? {
        guard let id = data["login"]["uuid"].string,
              let firstName = data["name"]["first"].string,
              let lastName = data["name"]["last"].string,
              let streetNumber = data["location"]["street"]["number"].number?.stringValue,
              let streetName = data["location"]["street"]["name"].string,
              let city = data["location"]["city"].string,
              let profileImageURLString = data["picture"]["large"].string
        else {
            Self.logger.error("Unable to parse profile data")
            return nil
        }

        return ProfileModel(
            id: id,
            firstName: firstName,
            lastName: lastName,
            streetNumber: streetNumber,
            streetName: streetName,
            city: city,
            profileImageURLString: profileImageURLString
        )
    }
}
