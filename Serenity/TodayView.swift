//
//  TodayView.swift
//  Serenity
//
//  Created by Roland Ramseier on 03.05.2026.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var store: CheckInStore
    @AppStorage("serenity.name") private var name: String = ""
    @Binding var showingCheckIn: Bool
    
    private var todayEntry: CheckIn? {
        store.entry(for: Date())
    }
    
    var body: some View {
        VStack(spacing: 20) {
            header
            Spacer()
            if let entry = todayEntry {
                summaryCard(entry: entry)
            } else {
                checkInCard
            }
            Spacer()
            tabBar
        }
        .padding()
    }
    
    var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Good day,")
                    .font(.title2)
                    .foregroundColor(.secondary)
                Text(name.isEmpty ? "Friend" : name)
                    .font(.largeTitle.bold())
            }
            Spacer()
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gearshape.fill")
                    .font(.title2)
            }
        }
    }
    
    var checkInCard: some View {
        VStack(spacing: 12) {
            Text("Today's check-in")
                .font(.title3.bold())
            Text("Takes about 2 minutes")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Button(action: { showingCheckIn = true }) {
                Text("Check in")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.top, 6)
            Button("View history") {
                // navigation later
            }
            .font(.footnote)
            .foregroundColor(.blue)
        }
        .padding()
        .frame(maxWidth: 500)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 4)
    }
    
    func summaryCard(entry: CheckIn) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: entry.mood.icon)
                    .font(.largeTitle)
                    .foregroundColor(entry.mood.color)
                VStack(alignment: .leading) {
                    Text(entry.mood.label).font(.title2.bold())
                    Text(entry.date, style: .date).font(.caption).foregroundColor(.secondary)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "square.and.pencil")
                }
            }
            Divider()
            Text("Gratitude").font(.headline)
            Text(entry.gratitude).font(.body)
                .lineLimit(3)
            if let mem = entry.memory, !mem.isEmpty {
                Divider()
                Text("Memory").font(.headline)
                Text(mem).font(.body).italic().lineLimit(3)
            } else {
                Divider()
                let q = sampleQuotes.randomElement()!
                Text("Quote").font(.headline)
                Text("“\(q.text)”").font(.body).italic()
                if let a = q.author { Text("- \(a)").font(.caption).foregroundColor(.secondary) }
            }
        }
        .padding()
        .frame(maxWidth: 600)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 4)
    }
    
    var tabBar: some View {
        HStack {
            Spacer()
            VStack { Image(systemName: "house.fill"); Text("Today").font(.caption) }
            Spacer()
            NavigationLink(destination: HistoryView()) {
                VStack { Image(systemName: "clock.fill"); Text("History").font(.caption) }
            }
            Spacer()
            NavigationLink(destination: FavoritesView()) {
                VStack { Image(systemName: "heart.fill"); Text("Favorites").font(.caption) }
            }
            Spacer()
            NavigationLink(destination: HelpView()) {
                VStack { Image(systemName: "questionmark.circle.fill"); Text("Help").font(.caption) }
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}
