//
//  ModeSelectionView.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import SwiftUI

struct ModeSelectionView: View {
    var body: some View {
        ZStack {
            Color.backgroundDark.ignoresSafeArea()

            VStack(spacing: 0) {
                // Main Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Headline
                        HeadlineView()

                        // Mode Grid
                        ModeGridView()

                        // Action Button
                        ConfigurationButton()
                    }
                    .padding()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}


// MARK: - Subviews
private struct HeadlineView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Wähle deinen Fokus")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)

            Text("Tippe auf eine Karte, um sie zu konfigurieren.")
                .font(.system(size: 16))
                .foregroundColor(.gray)
        }
    }
}

private struct ModeGridView: View {
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ModeCardView(
                iconName: "calendar",
                title: "Zeitplan-Modus",
                subtitle: "Apps nach Zeitplan blockieren"
            )
            ModeCardView(
                iconName: "hourglass",
                title: "Nutzungs-Modus",
                subtitle: "Tägliche Limits setzen"
            )
            ModeCardView(
                iconName: "hand.raised.fill",
                title: "Pickup-Modus",
                subtitle: "Entsperrungen begrenzen"
            )
            ModeCardView(
                iconName: "waves.data",
                title: "Flow-Modus",
                subtitle: "Sofortige Konzentration",
                isFeatured: true
            )
        }
    }
}

private struct ConfigurationButton: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "slider.horizontal.3")
                Text("Konfigurieren")
            }
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.backgroundDark)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.primaryGreen)
            .cornerRadius(16)
            .shadow(color: Color.primaryGreen.opacity(0.2), radius: 10, y: 5)
        }
        .padding(.top, 16)
    }
}

// MARK: - Reusable Components

struct ModeCardView: View {
    let iconName: String
    let title: String
    let subtitle: String
    var isFeatured: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                ZStack {
                    if isFeatured {
                        Circle()
                            .fill(Color.primaryGreen)
                            .shadow(color: .primaryGreen.opacity(0.4), radius: 8)
                        Image(systemName: iconName)
                            .foregroundColor(.backgroundDark)
                            .font(.system(size: 20, weight: .bold))
                    } else {
                        Circle()
                            .fill(Color.primaryGreen.opacity(0.1))
                        Image(systemName: iconName)
                            .foregroundColor(.primaryGreen)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
                .frame(width: 40, height: 40)
            }

            Spacer()

            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)

            Text(subtitle)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .padding()
        .frame(height: 180)
        .background(Color.surfaceDark)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isFeatured ? Color.primaryGreen.opacity(0.5) : Color.clear, lineWidth: 2)
        )
        .overlay(
            Text("Quick Start")
                .font(.system(size: 10, weight: .bold))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.primaryGreen)
                .foregroundColor(.backgroundDark)
                .clipShape(Capsule())
                .padding(12)
                .opacity(isFeatured ? 1 : 0),
            alignment: .topLeading
        )
    }
}

// MARK: - Preview
#Preview {
    ModeSelectionView()
}
