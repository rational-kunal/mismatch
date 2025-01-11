//
//  mismatchApp.swift
//  mismatch
//
//  Created by Kunal Kamble on 10/01/25.
//

import SwiftData
import SwiftUI

@main
struct mismatchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(SwiftDataService.shared.modelContainer)
    }
}
