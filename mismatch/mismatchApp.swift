//
//  mismatchApp.swift
//  mismatch
//
//  Created by Kunal Kamble on 19/03/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct mismatchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store:
                Store(initialState: Mismatch.State()) {
                    Mismatch() // ._printChanges()
                }
            )
        }.modelContainer(SwiftDataService.shared.modelContainer)
    }
}
