//
//  ContentView.swift
//  LiquidGlassTesting
//
//  Created by Sebastian Mendo on 1/28/26.
//

import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedTab") private var selectedTab = 0
    @State private var showingActionSheet = false
    @State private var showingAIChat = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView(selection: $selectedTab) {
                Tab("Journal", systemImage: "book.pages", value: 0) {
                    JournalView()
                }

                Tab("Insights", systemImage: "chart.bar.fill", value: 1) {
                    InsightsView()
                }
            }
            .tabViewStyle(.sidebarAdaptable)
            .tabBarMinimizeBehavior(.onScrollDown)

            // Floating action button
            Button {
                if selectedTab == 1 {
                    // On Insights tab - show AI Chat
                    showingAIChat = true
                } else {
                    // On Journal tab - show action sheet
                    showingActionSheet = true
                }
            } label: {
                Image(systemName: selectedTab == 1 ? "brain.head.profile" : "plus")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color.accentColor)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 20)
            .confirmationDialog("New Entry", isPresented: $showingActionSheet) {
                Button("New Journal Entry") {
                    // Handle new journal entry
                }

                Button("Quick Note") {
                    // Handle quick note
                }

                Button("Cancel", role: .cancel) { }
            }
            .sheet(isPresented: $showingAIChat) {
                AIChatView()
            }
        }
    }
}

#Preview {
    ContentView()
}
