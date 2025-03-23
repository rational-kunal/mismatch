import Alamofire
import os
import SwiftData
import SwiftUI
import SwiftyJSON

let PROFILE_API_URL = "https://randomuser.me/api/?results=10"

private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: ProfileDataService.self)
)

class ProfileDataService {
    // MARK: -  Data store

    static func loadLikedProfilesFromDataStore() async -> [ProfileModel]? {
        var fetchDescriptor = FetchDescriptor<ProfileModel>()
        fetchDescriptor.predicate = #Predicate<ProfileModel> { $0.liked }

        return try? SwiftDataService.shared.modelExecutor.modelContext.fetch(fetchDescriptor)
    }

    static func saveToDataStore(newProfile: ProfileModel) async {
        await SwiftDataService.shared.modelContainer.mainContext.insert(newProfile)

        do {
            try await SwiftDataService.shared.modelContainer.mainContext.save()
        } catch {
            logger.error("Error saving profiles to data store: \(error)")
        }
    }

    static func deleteFromDataStore(profile: ProfileModel) async {
        let context = await SwiftDataService.shared.modelContainer.mainContext

        // Fetch the object before deleting to ensure it's in the context
        let fetchDescriptor = FetchDescriptor<ProfileModel>()
        let allProfiles = try? context.fetch(fetchDescriptor)

        guard let existingProfile = allProfiles?.first(where: { $0.id == profile.id }) else {
            logger.error("Profile not found in context")
            return
        }

        context.delete(existingProfile)

        do {
            try await context.save()
            logger.debug("Successfully deleted profile: \(profile.id)")
        } catch {
            logger.error("Error deleting profile from data store: \(error)")
        }
    }

    // MARK: - Network

    static func fetchMoreExploreProfilesFromNetwork() async -> [ProfileModel]? {
        let data = try? await AF.request(PROFILE_API_URL).serializingData().value

        guard let data, let results = JSON(data)["results"].array else {
            logger.error("Error while decoding profiles response")
            return nil
        }

        var profiles = [ProfileModel]()
        for profileResultJSON in results {
            guard let profileModel = ProfileModel.parse(json: profileResultJSON) else {
                continue
            }

            profiles.append(profileModel)
        }

        return profiles
    }
}
