//
//  Store.swift
//  Serenity
//
//  Created by Roland Ramseier on 03.05.2026.
//

import Foundation
import SwiftUI
import Combine

final class CheckInStore: ObservableObject {
    @Published private(set) var checkIns: [CheckIn] = []
    private let key = "serenity.checkins.v1"
    
    init() {
        load()
    }
    
    func save(_ checkIn: CheckIn) {
        // Replace today's entry if exists
        if let idx = checkIns.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: checkIn.date) }) {
            checkIns[idx] = checkIn
        } else {
            checkIns.insert(checkIn, at: 0)
        }
        persist()
    }
    
    func entry(for date: Date) -> CheckIn? {
        checkIns.first(where: { Calendar.current.isDate($0.date, inSameDayAs: date) })
    }
    
    private func persist() {
        if let data = try? JSONEncoder().encode(checkIns) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let items = try? JSONDecoder().decode([CheckIn].self, from: data) else { return }
        checkIns = items
    }
    
    func delete(_ id: UUID) {
        checkIns.removeAll { $0.id == id }
        persist()
    }
}
