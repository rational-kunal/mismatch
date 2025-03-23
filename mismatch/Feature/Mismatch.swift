import Clocks
import ComposableArchitecture
import Foundation
import NeoBrutalism
import os
import SwiftUI

// MARK: - Logger

private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: Mismatch.self)
)

// MARK: - Theme Extension

extension Theme {
    static var lovely: Theme {
        .default.updateBy(
            main: Color(light: .rgb(1.0, 0.42, 0.42), dark: .rgb(1.0, 0.42, 0.42)),
            bw: Color(light: .rgb(1.0, 1.0, 1.0), dark: .rgb(0.129, 0.129, 0.129)),
            background: Color(light: .rgb(0.988, 0.843, 0.843), dark: .rgb(0.153, 0.161, 0.2))
        )
    }
}

// MARK: - Mismatch Reducer

struct Mismatch: Reducer {
    var body: some ReducerOf<Mismatch> {
        Reduce { state, action in
            switch action {
            // MARK: - Fetch Next Profiles

            case .fetchNextExploreProfiles:
                guard !state.isFetchingNextExploreProfiles else {
                    logger.error("Already fetching next explore profiles")
                    return .none
                }

                state.isFetchingNextExploreProfiles = true
                return .run { send in
                    if let moreProfiles = await ProfileDataService.fetchMoreExploreProfilesFromNetwork() {
                        try await Task.sleep(for: .seconds(2)) // Simulating delay
                        await send(.appendExploreProfiles(moreProfiles))
                    }
                }

            // MARK: - Append Fetched Profiles

            case let .appendExploreProfiles(profiles):
                state.isFetchingNextExploreProfiles = false
                withAnimation { state.exploreProfiles.append(contentsOf: profiles) }
                return .none

            // MARK: - Like Profile

            case let .likeProfile(profile):
                profile.toggleLikeOnModelLevel()
                withAnimation {
                    state.exploreProfiles.removeAll { $0.id == profile.id }
                    state.likedProfiles.append(profile)
                }
                return .run { _ in await ProfileDataService.saveToDataStore(newProfile: profile) }

            // MARK: - Dislike Profile

            case let .dislikeProfile(profile):
                withAnimation {
                    state.exploreProfiles.removeAll { $0.id == profile.id }
                    state.likedProfiles.removeAll { $0.id == profile.id }
                }
                return .run { _ in await ProfileDataService.deleteFromDataStore(profile: profile) }

            // MARK: - Change Tab

            case let .tabChanged(tab):
                return handleTabChange(state: &state, tab: tab)

            // MARK: - Load Liked Profiles

            case let .loadLikedProfiles(profiles):
                state.likedProfiles = profiles
                return .none
            }
        }
    }

    // MARK: - Handle Tab Change

    private func handleTabChange(state: inout State, tab: State.Tab) -> Effect<Action> {
        withAnimation { state.selectedTab = tab }

        guard tab == .liked else { return .none }

        return .run { send in
            if let likedProfiles = await ProfileDataService.loadLikedProfilesFromDataStore() {
                await send(.loadLikedProfiles(likedProfiles))
            }
        }
    }

    // MARK: - Actions

    enum Action: Equatable {
        case fetchNextExploreProfiles
        case appendExploreProfiles([ProfileModel])
        case likeProfile(ProfileModel)
        case dislikeProfile(ProfileModel)
        case tabChanged(State.Tab)
        case loadLikedProfiles([ProfileModel])
    }

    // MARK: - State

    @ObservableState
    struct State: Equatable {
        var selectedTab: Tab = .explore
        var isFetchingNextExploreProfiles = false
        var exploreProfiles: [ProfileModel] = []
        var likedProfiles: [ProfileModel] = []

        var theme: Theme {
            selectedTab == .liked ? .lovely : .default
        }

        enum Tab: String {
            case explore, liked
        }
    }
}
