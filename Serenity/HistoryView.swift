//
//  HistoryView.swift
//  Serenity
//
//  Created by Roland Ramseier on 03.05.2026.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var store: CheckInStore
    var body: some View {
        List {
            ForEach(store.checkIns) { item in
                HStack {
                    Image(systemName: item.mood.icon).foregroundColor(item.mood.color)
                    VStack(alignment: .leading) {
                        Text(item.gratitude).lineLimit(1)
                        Text(item.date, style: .date).font(.caption).foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("History")
    }
}

struct FavoritesView: View {
    var body: some View {
        Text("Favorites (placeholder)").navigationTitle("Favorites")
    }
}

struct HelpView: View {
    var body: some View {
        Text("Tips: Keep entries short. Use reminders.").navigationTitle("Help")
    }
}

