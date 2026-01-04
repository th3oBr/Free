//
//  FlowModeView.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import SwiftUI

struct FlowModeView: View {
    @State private var focusDuration: Double = 25 // in minutes
    @State private var isStrictMode = false
    @State private var playZenSound = true

    var body: some View {
        ZStack {
            Color(red: 16/255, green: 34/255, blue: 22/255).ignoresSafeArea()

            VStack(spacing: 0) {
                HeaderView()

                ScrollView {
                    VStack(spacing: 24) {
                        TimerDisplay(duration: focusDuration)

                        DurationSlider(duration: $focusDuration)

                        BlockedAppsCard()

                        OptionsToggles(isStrictMode: $isStrictMode, playZenSound: $playZenSound)
                    }
                    .padding()
                }

                CTAButton()
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
            Text("Flow Mode").bold()
            Spacer()
            Button(action: {}) { Image(systemName: "gearshape.fill") }
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.backgroundDark.opacity(0.8))
    }
}

private struct TimerDisplay: View {
    let duration: Double

    private var endTime: String {
        let now = Date()
        let ending = now.addingTimeInterval(duration * 60)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: ending)
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.primaryGreen.opacity(0.05))
                .blur(radius: 30)
                .frame(width: 200, height: 200)

            VStack {
                Text(String(format: "%02d:00", Int(duration)))
                    .font(.system(size: 72, weight: .bold))
                    .monospacedDigit()

                Text("Ends at \(endTime)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 32)
    }
}

private struct DurationSlider: View {
    @Binding var duration: Double

    var body: some View {
        VStack {
            HStack {
                Text("Focus Duration")
                    .font(.headline)
                Spacer()
                Text("\(Int(duration)) min")
                    .font(.headline)
                    .foregroundColor(.primaryGreen)
            }

            Slider(value: $duration, in: 5...120, step: 5)
                .tint(.primaryGreen)

            HStack {
                Text("5m").font(.caption).foregroundColor(.gray)
                Spacer()
                Text("30m").font(.caption).foregroundColor(.gray)
                Spacer()
                Text("60m").font(.caption).foregroundColor(.gray)
                Spacer()
                Text("120m").font(.caption).foregroundColor(.gray)
            }
        }
    }
}

private struct BlockedAppsCard: View {
    var body: some View {
        HStack {
            Image(systemName: "app.badge.xmark.fill")
                .frame(width: 50, height: 50)
                .background(Color.white.opacity(0.05))
                .foregroundColor(.gray)
                .cornerRadius(12)

            VStack(alignment: .leading) {
                Text("Distractions Blocked").bold()
                Text("Instagram, TikTok, Slack, Mail")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(16)
    }
}

private struct OptionsToggles: View {
    @Binding var isStrictMode: Bool
    @Binding var playZenSound: Bool

    var body: some View {
        VStack(spacing: 12) {
            ToggleRow(
                title: "Strict Mode",
                subtitle: "Cannot pause or cancel early",
                iconName: "lock.fill",
                isOn: $isStrictMode
            )
            ToggleRow(
                title: "Zen Sound",
                subtitle: "Play ambient white noise",
                iconName: "speaker.wave.2.fill",
                isOn: $playZenSound
            )
        }
    }
}

private struct ToggleRow: View {
    let title: String
    let subtitle: String
    let iconName: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.gray)
                .frame(width: 24)

            VStack(alignment: .leading) {
                Text(title).bold()
                Text(subtitle).font(.caption).foregroundColor(.gray)
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .tint(.primaryGreen)
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(16)
    }
}

private struct CTAButton: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "bolt.fill")
                Text("Enter Flow State")
            }
            .font(.headline).bold()
            .foregroundColor(.backgroundDark)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.primaryGreen)
            .cornerRadius(28)
            .shadow(color: .primaryGreen.opacity(0.3), radius: 10, y: 5)
        }
        .padding()
    }
}


#Preview {
    FlowModeView()
}
