//
//  PickupModeView.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import SwiftUI

struct PickupModeView: View {
    @State private var unlockLimit: Double = 50
    @State private var isStrictMode = false
    @State private var areNudgesEnabled = true

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 16/255, green: 34/255, blue: 22/255).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 32) {
                    HeaderView()

                    HeroTextView()

                    UnlockLimitDisplay(unlockLimit: $unlockLimit)

                    CustomSliderView(value: $unlockLimit, in: 0...150)

                    InfoNudgeView()

                    ConfigurationGroup(isStrictMode: $isStrictMode, areNudgesEnabled: $areNudgesEnabled)

                    // Spacer for the sticky footer
                    Spacer(minLength: 120)
                }
            }

            StickyFooterButton()
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
            Text("Pickup Mode").bold()
            Spacer()
            Button(action: {}) { Image(systemName: "questionmark.circle") }
        }
        .foregroundColor(.white)
        .padding()
    }
}

private struct HeroTextView: View {
    var body: some View {
        VStack {
            Text("Set Your Daily Limit")
                .font(.system(size: 28, weight: .bold))
            Text("How many times do you want to unlock your phone today?")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

private struct UnlockLimitDisplay: View {
    @Binding var unlockLimit: Double

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.primaryGreen.opacity(0.2))
                .blur(radius: 60)
                .frame(width: 160, height: 160)

            VStack {
                Text("\(Int(unlockLimit))")
                    .font(.system(size: 96, weight: .extrabold))
                    .tracking(-5)
                Text("Unlocks")
                    .font(.headline)
                    .foregroundColor(.primaryGreen)
                    .tracking(2)
                    .textCase(.uppercase)
            }
        }
    }
}

private struct CustomSliderView: View {
    @Binding var value: Double
    let `in`: ClosedRange<Double>

    var body: some View {
        VStack {
            Slider(value: $value, in: `in`, step: 1)
                .tint(.primaryGreen)

            InfoNudgeView()
        }
        .padding(.horizontal, 30)
    }
}

private struct InfoNudgeView: View {
    var body: some View {
        HStack {
            Image(systemName: "info.circle.fill")
                .foregroundColor(.primaryGreen)
            Text("Average users unlock their phone **80 times** a day. Setting a limit of 50 saves approx. 45 mins.")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.primaryGreen.opacity(0.1))
        .cornerRadius(12)
    }
}

private struct ConfigurationGroup: View {
    @Binding var isStrictMode: Bool
    @Binding var areNudgesEnabled: Bool

    var body: some View {
        VStack(spacing: 12) {
            Text("Configuration")
                .font(.caption).bold()
                .foregroundColor(.gray)
                .textCase(.uppercase)
                .frame(maxWidth: .infinity, alignment: .leading)

            ConfigurationRow(
                title: "Strict Mode",
                subtitle: "Block apps after limit",
                iconName: "gpp.maybe",
                iconColor: .red,
                content: AnyView(Toggle("", isOn: $isStrictMode).tint(.primaryGreen))
            )

            ConfigurationRow(
                title: "Schedule",
                subtitle: "Every Day",
                iconName: "calendar.today",
                iconColor: .blue,
                content: AnyView(Image(systemName: "chevron.right").foregroundColor(.gray))
            )

            ConfigurationRow(
                title: "Nudge Notifications",
                subtitle: "Remind me when close",
                iconName: "notifications.active",
                iconColor: .primaryGreen,
                content: AnyView(Toggle("", isOn: $areNudgesEnabled).tint(.primaryGreen))
            )
        }
        .padding(.horizontal)
    }
}

private struct ConfigurationRow<Content: View>: View {
    let title: String
    let subtitle: String
    let iconName: String
    let iconColor: Color
    let content: Content

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .frame(width: 40, height: 40)
                .background(iconColor.opacity(0.1))
                .foregroundColor(iconColor)
                .cornerRadius(20)

            VStack(alignment: .leading) {
                Text(title).bold()
                Text(subtitle).font(.caption).foregroundColor(subtitle == "Every Day" ? .primaryGreen : .gray)
            }

            Spacer()

            content
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(20)
    }
}

private struct StickyFooterButton: View {
    @State private var shimmer = false

    var body: some View {
        Button(action: {}) {
            HStack {
                Text("Start Pickup Mode")
                Image(systemName: "bolt.fill")
            }
            .bold()
            .foregroundColor(.backgroundDark)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                ZStack {
                    Color.primaryGreen
                    if shimmer {
                        Color.white.opacity(0.3)
                            .mask(Rectangle().fill(LinearGradient(gradient: Gradient(colors: [.clear, .white, .clear]), startPoint: .leading, endPoint: .trailing)))
                            .transition(.offset(x: -200, y: 0))
                            .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: shimmer)
                    }
                }
            )
            .cornerRadius(20)
            .shadow(color: .primaryGreen.opacity(0.3), radius: 10)
        }
        .padding()
        .background(Color.backgroundDark.opacity(0.8).blur(radius: 10))
        .onAppear {
            shimmer = true
        }
    }
}

#Preview {
    PickupModeView()
}
