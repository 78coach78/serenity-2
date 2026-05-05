//
//  SettingsView.swift
//  Serenity
//
//  Created by Roland Ramseier on 03.05.2026.
//


import SwiftUI

struct SettingsView: View {
    @AppStorage("serenity.notificationsEnabled") private var notificationsEnabled: Bool = true
    @AppStorage("serenity.name") private var name: String = ""
    var body: some View {
        Form {
            Section(header: Text("Profile")) {
                TextField("Name", text: $name)
            }
            Section(header: Text("Reminders")) {
                Toggle("Daily reminder", isOn: $notificationsEnabled)
            }
            Section {
                Button("Clear all local data") { UserDefaults.standard.removeObject(forKey: "serenity.checkins.v1") }
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Settings")
    }

}
