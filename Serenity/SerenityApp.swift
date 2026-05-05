//
//  SerenityApp.swift
//  Serenity
//
//  Created by Roland Ramseier on 03.05.2026.
//

import SwiftUI

@main
struct SerenityApp: App {
    @StateObject private var store = CheckInStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
