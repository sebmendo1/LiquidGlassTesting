//
//  InsightsView.swift
//  LiquidGlassTesting
//
//  Created by Sebastian Mendo on 1/28/26.
//

import SwiftUI
import Charts

struct InsightsView: View {
    @State private var selectedDate = Date()
    @State private var showingMonthPicker = false
    @Environment(\.theme) private var theme

    private var selectedMonthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: selectedDate)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                theme.insightsBackgroundStart
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 16) {
                        Text("Add content")
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Insights")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // Search action
                    } label: {
                        Image(systemName: "person.fill")
                            .foregroundStyle(.white)
                    }
                    .accessibilityLabel("Profile")
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingMonthPicker = true
                    } label: {
                        Text(selectedMonthYear)
                            .foregroundStyle(.white)
                        Image(systemName: "calendar")
                            .foregroundStyle(.white)
                    }
                    .accessibilityLabel("Select month, currently \(selectedMonthYear)")
                }
            }
            .sheet(isPresented: $showingMonthPicker) {
                MonthPickerView(selectedDate: $selectedDate, isPresented: $showingMonthPicker)
            }
        }
    }
}

struct MonthPickerView: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool

    @State private var selectedMonth: Int

    private let months = Calendar.current.monthSymbols

    init(selectedDate: Binding<Date>, isPresented: Binding<Bool>) {
        self._selectedDate = selectedDate
        self._isPresented = isPresented

        let calendar = Calendar.current
        let month = calendar.component(.month, from: selectedDate.wrappedValue)

        self._selectedMonth = State(initialValue: month)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Select Month")
                    .font(.headline)
                    .padding(.top)

                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { month in
                        Text(months[month - 1])
                            .tag(month)
                    }
                }
                .pickerStyle(.wheel)
                .padding(.horizontal)

                Spacer()
            }
            .navigationTitle("Select Month")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        updateSelectedDate()
                        isPresented = false
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }

    private func updateSelectedDate() {
        var components = Calendar.current.dateComponents([.day], from: selectedDate)
        components.month = selectedMonth
        components.year = 2026
        components.day = 1

        if let newDate = Calendar.current.date(from: components) {
            selectedDate = newDate
        }
    }
}

struct InsightCard: View {
    let title: String
    let value: String
    let subtitle: String
    let trend: Trend

    enum Trend {
        case up, down, neutral

        var icon: String {
            switch self {
            case .up: return "arrow.up.right"
            case .down: return "arrow.down.right"
            case .neutral: return "minus"
            }
        }

        var color: Color {
            switch self {
            case .up: return .green
            case .down: return .red
            case .neutral: return .gray
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack(alignment: .firstTextBaseline) {
                Text(value)
                    .font(.system(size: 32, weight: .bold))

                Spacer()

                Image(systemName: trend.icon)
                    .foregroundStyle(trend.color)
                    .imageScale(.medium)
            }

            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(.white, in: RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(value) \(subtitle)")
        .accessibilityValue(trendAccessibilityValue)
    }

    private var trendAccessibilityValue: String {
        switch trend {
        case .up: return "Trending up"
        case .down: return "Trending down"
        case .neutral: return "No change"
        }
    }
}

#Preview {
    InsightsView()
}
