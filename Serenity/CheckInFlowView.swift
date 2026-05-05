//
//  CheckInFlowView.swift
//  Serenity
//
//  Created by Roland Ramseier on 03.05.2026.
//

import SwiftUI
struct CheckInFlowView: View {
    @EnvironmentObject var store: CheckInStore
    @Binding var isPresented: Bool
    
    @State private var step = 1
    @State private var selectedMood: Mood = .neutral
    @State private var gratitude: String = ""
    @State private var memory: String = ""

    var body: some View {
        NavigationView {
            VStack {
                progressView
                Spacer()
                content
                Spacer()
                bottomButtons
            }
            .padding()
            .navigationBarHidden(true)
        }
    }

    var progressView: some View {
        HStack {
            ForEach(1...3, id: \.self) { i in
                Circle()
                    .fill(i <= step ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 10, height: 10)
            }
        }
    }

    @ViewBuilder
    var content: some View {
        switch step {
        case 1: moodStep
        case 2: gratitudeStep
        case 3: memoryStep
        default: moodStep
        }
    }

    var moodStep: some View {
        VStack(spacing: 16) {
            Text("How are you feeling?")
                .font(.title2.bold())
            HStack(spacing: 12) {
                ForEach(Mood.allCases, id: \.self) { mood in
                    Button(action: { selectedMood = mood }) {
                        VStack {
                            Image(systemName: mood.icon)
                                .font(.title)
                                .foregroundColor(selectedMood == mood ? .white : mood.color)
                                .padding()
                                .background(selectedMood == mood ? mood.color : Color(.systemGray6))
                                .clipShape(Circle())
                            Text(mood.label)
                                .font(.caption)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel(mood.label)
                }
            }
        }
    }

    var gratitudeStep: some View {
        VStack(spacing: 12) {
            Text("What are you grateful for?")
                .font(.title2.bold())
            TextField("One thing you’re grateful for…", text: $gratitude)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            HStack {
                Button("Suggestion: Sunshine") { gratitude = "The sunshine today" }
                Spacer()
            }
            .font(.footnote)
            .foregroundColor(.blue)
            .padding(.horizontal)
        }
    }

    var memoryStep: some View {
        VStack(spacing: 12) {
            Text("Remember a good moment (optional)")
                .font(.title2.bold())
            TextEditor(text: $memory)
                .frame(height: 120)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                .padding(.horizontal)
            Toggle("Skip adding a memory", isOn: Binding(get: { memory.isEmpty }, set: { if $0 { memory = "" } }))
                .padding(.horizontal)
        }
    }

    var bottomButtons: some View {
        HStack {
            if step > 1 {
                Button("Back") { step -= 1 }
                    .padding()
            }
            Spacer()
            if step < 3 {
                Button("Next") { step += 1 }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            } else {
                Button("Save") { saveAndClose() }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }

    func saveAndClose() {
        let entry = CheckIn(mood: selectedMood, gratitude: gratitude.trimmingCharacters(in: .whitespacesAndNewlines), memory: memory.trimmingCharacters(in: .whitespacesAndNewlines))
        store.save(entry)
        isPresented = false
    }

}
