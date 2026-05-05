//
//  OnboardingView.swift
//  Serenity
//
//  Created by Roland Ramseier on 03.05.2026.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss)private var dismiss
    
    @AppStorage("serenity.name") private var name: String = ""
    @AppStorage("serenity.notificationsEnabled") private var notificationsEnabled: Bool = true

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to Serenity").font(.largeTitle).bold()
                Text("A 2–3 minute daily check-in for calm and gratitude")
                    .multilineTextAlignment(.center)
                TextField("Your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Toggle("Daily reminder", isOn: $notificationsEnabled)
                    .padding(.horizontal)
                Spacer()
                Button("Get Started") {
                    dismiss()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding()
        }
    }
  
    

 }
