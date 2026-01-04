//
//  UsageRulesView.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import SwiftUI
import Charts

struct UsageRulesView: View {
    @State private var isEnabled = true
    @State private var activeTime: Double = 5
    @State private var cooldownTime: Double = 10
    @State private var selectedPreset = "Quick Check"

    let presets = ["Pomodoro (25m/5m)", "Quick Check (5m/10m)", "Strict (15m/1h)"]

    var body: some View {
        ZStack {
            Color(red: 16/255, green: 34/255, blue: 22/255).ignoresSafeArea()

            VStack(spacing: 0) {
                HeaderView()

                ScrollView {
                    VStack(spacing: 24) {
                        AppContextCard(isEnabled: $isEnabled)

                        Text("Configure how long you can use this app, and the mandatory break that follows.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        PresetsView(selectedPreset: $selectedPreset, presets: presets)

                        TimeControls(activeTime: $activeTime, cooldownTime: $cooldownTime)

                        CyclePreviewChart(activeTime: activeTime, cooldownTime: cooldownTime)

                        Spacer(minLength: 100) // For bottom button
                    }
                    .padding()
                }
            }

            VStack {
                Spacer()
                StickyFooterButton()
            }
        }
        .preferredColorScheme(.dark)
    }
}


// MARK: - Subviews
private struct HeaderView: View {
    var body: some View {
        HStack {
            Button(action: {}) { Image(systemName: "arrow.backward") }
            Spacer()
            Text("Usage Rules").bold()
            Spacer()
            // Spacer for centering
            Color.clear.frame(width: 30)
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.backgroundDark.opacity(0.8))
        .overlay(Rectangle().frame(height: 1).foregroundColor(.white.opacity(0.1)), alignment: .bottom)
    }
}

private struct AppContextCard: View {
    @Binding var isEnabled: Bool

    var body: some View {
        HStack {
            Image(systemName: "camera.fill")
                .font(.title)
                .frame(width: 50, height: 50)
                .background(LinearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(12)

            VStack(alignment: .leading) {
                Text("Instagram").bold()
                Text("Social").font(.caption).foregroundColor(.gray)
            }

            Spacer()

            Text("Enabled").font(.subheadline).foregroundColor(.gray)
            Toggle("", isOn: $isEnabled).tint(.primaryGreen)
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(20)
    }
}

private struct PresetsView: View {
    @Binding var selectedPreset: String
    let presets: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(presets, id: \.self) { preset in
                    Button(action: { selectedPreset = preset }) {
                        Text(preset)
                            .font(.caption).bold()
                            .padding(.horizontal, 16).padding(.vertical, 8)
                            .background(selectedPreset == preset ? Color.primaryGreen.opacity(0.2) : Color.surfaceDark)
                            .foregroundColor(selectedPreset == preset ? .primaryGreen : .white)
                            .cornerRadius(20)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(selectedPreset == preset ? Color.primaryGreen.opacity(0.5) : Color.white.opacity(0.1)))
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

private struct TimeControls: View {
    @Binding var activeTime: Double
    @Binding var cooldownTime: Double

    var body: some View {
        HStack(spacing: 16) {
            TimeControlCard(title: "Active Time", value: $activeTime, range: 1...60, color: .primaryGreen, icon: "play.circle.fill")
            TimeControlCard(title: "Cooldown", value: $cooldownTime, range: 5...120, color: .gray, icon: "hourglass")
        }
    }
}

private struct TimeControlCard: View {
    let title: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let color: Color
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title.uppercased()).font(.caption2).bold().foregroundColor(.gray)
                    Text("\(Int(value))").font(.title).bold() + Text(" min").font(.caption).foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: icon).font(.title).foregroundColor(color.opacity(0.2))
            }
            Slider(value: $value, in: range, step: 1).tint(color)
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(20)
    }
}

struct CycleData: Identifiable {
    let id = UUID()
    let type: String
    let value: Double
    let time: Double
}

private struct CyclePreviewChart: View {
    let activeTime: Double
    let cooldownTime: Double

    var body: some View {
        VStack(alignment: .leading) {
            Text("Cycle Preview").font(.caption).bold().textCase(.uppercase).foregroundColor(.gray)
            Text("Active vs Cooldown").font(.headline).bold()

            // Simplified visual representation
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.primaryGreen)
                    .frame(height: 50)
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: CGFloat(cooldownTime / activeTime) * 100, height: 50) // Proportional width
                Rectangle()
                    .fill(Color.primaryGreen.opacity(0.5))
                    .frame(height: 50)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                HStack {
                    Text("ACTIVE").font(.caption).bold()
                    Spacer()
                    Text("COOLDOWN").font(.caption).bold()
                    Spacer()
                    Text("ACTIVE").font(.caption).bold()
                }
                .padding(.horizontal)
                .foregroundColor(.black.opacity(0.6))
            )
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(20)
    }
}


private struct StickyFooterButton: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "checkmark")
                Text("Save Rules")
            }
            .bold()
            .foregroundColor(.backgroundDark)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.primaryGreen)
            .cornerRadius(20)
            .shadow(color: .primaryGreen.opacity(0.3), radius: 10)
        }
        .padding()
        .background(Color.backgroundDark.opacity(0.8).blur(radius: 10))
    }
}

#Preview {
    UsageRulesView()
}
