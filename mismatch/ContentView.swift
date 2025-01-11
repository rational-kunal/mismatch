//
//  ContentView.swift
//  mismatch
//
//  Created by Kunal Kamble on 10/01/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var profileModels: [ProfileModel]
    
    let x: ProfileDataService = {
        let x = ProfileDataService()
        x.fetchMoreProfilesIfNeeded()
        return x
    }()

    var body: some View {
        ProfileCardListView(profileModelList: profileModels)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ProfileModel.self, inMemory: true)
}
