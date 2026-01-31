//
//  JournalView.swift
//  LiquidGlassTesting
//
//  Created by Sebastian Mendo on 1/28/26.
//

import SwiftUI

struct JournalView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<10) { index in
                        JournalEntryCard(title: "Entry \(index + 1)", date: Date())
                    }
                }
                .padding()
            }
            .background(Color(red: 0.933, green: 0.937, blue: 0.957))
            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // Search action
                    } label: {
                        Image(systemName: "person.fill")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Search action
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Filter action
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
    }
}

struct JournalEntryCard: View {
    let title: String
    let date: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            Text(date, style: .date)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text("Sample journal entry content goes here. This is where you would write your thoughts and reflections.")
                .font(.body)
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    JournalView()
}
