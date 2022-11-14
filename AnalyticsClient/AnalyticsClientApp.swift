//
//  AnalyticsClientApp.swift
//  AnalyticsClient
//
//  Created by Gabriel Tondin on 14/11/2022.
//

import SwiftUI
import ComposableArchitecture

@main
struct AnalyticsClientApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: ContentStore.State(),
                    reducer: ContentStore()
                )
            )
        }
    }
}
