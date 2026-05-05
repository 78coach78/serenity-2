//
//  ContentView.swift
//  Serenity
//
//  Created by Roland Ramseier on 03.05.2026.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: CheckInStore
    @AppStorage("serenity.name") private var name: String = ""
    @AppStorage("serenity.notificationsEnabled") private var notificationsEnabled: Bool = true
    @State private var showingOnboarding = false
    @State private var showingCheckIn = false
    
    var body: some View {
        NavigationView {
            TodayView(showingCheckIn: $showingCheckIn)
                .navigationBarHidden(true)
                .onAppear {
                    if name.isEmpty { showingOnboarding = true }
                }
                .sheet(isPresented: $showingOnboarding) {
                    OnboardingView()
                }
                .sheet(isPresented: $showingCheckIn) {
                    CheckInFlowView(isPresented: $showingCheckIn)
                        .environmentObject(store)
                }
        }
    }

    
}
