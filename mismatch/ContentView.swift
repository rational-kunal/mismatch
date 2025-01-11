//
//  ContentView.swift
//  mismatch
//
//  Created by Kunal Kamble on 10/01/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @StateObject var profileDataService = ProfileDataService.shared

    var body: some View {
        VStack {
            Text("mismatch!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(alignment: .leading)
                .padding()

            if profileDataService.profileQueue.isEmpty {
                ProgressView()
                    .frame(maxHeight: .infinity)
            } else {
                ProfileCardListView(profileModelList: profileDataService.profileQueue)
                    .frame(maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ProfileModel.self, inMemory: true)
}
