//
//  AIChatView.swift
//  LiquidGlassTesting
//
//  Created by Sebastian Mendo on 1/28/26.
//

import SwiftUI

struct AIChatView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var messages: [ChatMessage] = []
    @State private var inputText = ""
    @FocusState private var isInputFocused: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Messages
                ScrollView {
                    VStack(spacing: 16) {
                        if messages.isEmpty {
                            emptyStateView
                        } else {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                            }
                        }
                    }
                    .padding()
                }
                .background(Color(red: 0.933, green: 0.937, blue: 0.957))

                Divider()

                // Input area
                HStack(spacing: 12) {
                    TextField("Message", text: $inputText, axis: .vertical)
                        .textFieldStyle(.plain)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .focused($isInputFocused)
                        .lineLimit(1...6)

                    Button {
                        sendMessage()
                    } label: {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title2)
                            .foregroundStyle(inputText.isEmpty ? Color.gray : Color(red: 0.380, green: 0.145, blue: 0.694))
                    }
                    .disabled(inputText.isEmpty)
                }
                .padding()
                .background(.white)
            }
            .navigationTitle("AI Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                            .font(.title3)
                    }
                }
            }
        }
        .onAppear {
            isInputFocused = true
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 60))
                .foregroundStyle(Color(red: 0.380, green: 0.145, blue: 0.694))

            Text("AI Assistant")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Ask me anything about your journal entries or get insights about your thoughts")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding(.top, 60)
    }

    private func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let userMessage = ChatMessage(content: inputText, isUser: true)
        messages.append(userMessage)

        inputText = ""

        // Simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let aiResponse = ChatMessage(
                content: "I'm here to help you explore your thoughts and journal entries. This is a placeholder response.",
                isUser: false
            )
            messages.append(aiResponse)
        }
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp = Date()
}

struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.isUser {
                Spacer(minLength: 60)
            }

            if !message.isUser {
                Image(systemName: "brain.head.profile")
                    .font(.title3)
                    .foregroundStyle(Color(red: 0.380, green: 0.145, blue: 0.694))
                    .frame(width: 32, height: 32)
            }

            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .font(.body)
                    .foregroundStyle(message.isUser ? .white : .primary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        message.isUser
                            ? Color(red: 0.380, green: 0.145, blue: 0.694)
                            : .white
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

            if !message.isUser {
                Spacer(minLength: 60)
            }
        }
    }
}

#Preview {
    AIChatView()
}
