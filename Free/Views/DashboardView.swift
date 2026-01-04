//
//  DashboardView.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import SwiftUI

struct DashboardView: View {
    @State private var isFocusModeOn = true

    // Data for the progress ring (2h 15m / 4h total = 2.25h / 4h = 0.5625)
    let screenTimeProgress = 0.5625

    var body: some View {
        ZStack {
            Color(red: 16/255, green: 34/255, blue: 22/255).ignoresSafeArea()

            VStack(spacing: 0) {
                HeaderView()

                ScrollView {
                    VStack(spacing: 32) {
                        CircularProgressView(progress: screenTimeProgress)
                        ActiveModeCard(isFocusModeOn: $isFocusModeOn)
                        QuickActionsGrid()
                        UsageBreakdownSection()
                        Spacer(minLength: 100) // For bottom nav bar
                    }
                    .padding()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Subviews
private struct HeaderView: View {
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: URL(string: "https://lh3.googleusercontent.com/aida-public/AB6AXuDytnjEptJkUrRQNoW9ZtbUEMKu5-VVwnSu1-6Xxt533NavQ8mRKkLIQ-8TR6tOR0emaoSmKiCwqKSdC-j1b3y-arpjaO8KLcZNZMlvTR5sLbmLsm3aki3ZSWqtM0Z4_wR3dFgrEDsL7FZvIEiSWSnqeyvSZ2unY4SJULPc9bjHnACO3YYQSocTT3G9fA2uOQfbG6B0jmpfJtoME2gDI36emrDFsVkYnE2Ve3GfnkjLhy_JQ_1yiNoR5qxO70rHiLYvWAG-Itqtge5K")) { image in
                        image.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: { Color.gray.opacity(0.3) }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.primaryGreen, lineWidth: 2))

                    Circle()
                        .fill(Color.primaryGreen)
                        .frame(width: 12, height: 12)
                        .overlay(Circle().stroke(Color.backgroundDark, lineWidth: 2))
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("Good Morning,").font(.caption).foregroundColor(.gray)
                    Text("Alex").font(.headline).bold()
                }
            }

            Spacer()

            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .font(.title3)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.backgroundDark.opacity(0.8))
    }
}

private struct CircularProgressView: View {
    let progress: Double

    var body: some View {
        VStack {
            ZStack {
                Circle().fill(Color.primaryGreen.opacity(0.2)).blur(radius: 20)

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.primaryGreen, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .background(Circle().stroke(Color.white.opacity(0.1), lineWidth: 12))

                VStack {
                    Text("Screen Time").font(.caption).foregroundColor(.gray)
                    Text("2")
                        .font(.system(size: 48, weight: .bold))
                        .baselineOffset(-10)
                    + Text("h").font(.title).bold()
                    + Text(" 15").font(.system(size: 48, weight: .bold)).baselineOffset(-10)
                    + Text("m").font(.title).bold()

                    Text("1h 45m remaining")
                        .font(.caption).bold()
                        .foregroundColor(.primaryGreen)
                }
            }
            .frame(width: 200, height: 200)

            Text("Daily Goal: **4h 00m**")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top)
        }
    }
}

private struct ActiveModeCard: View {
    @Binding var isFocusModeOn: Bool

    var body: some View {
        HStack {
            Image(systemName: "brain.head.profile")
                .frame(width: 50, height: 50)
                .background(Color.primaryGreen.opacity(0.2))
                .foregroundColor(.primaryGreen)
                .cornerRadius(12)

            VStack(alignment: .leading) {
                Text("Deep Work").font(.headline).bold()
                HStack {
                    Circle().fill(Color.primaryGreen).frame(width: 6, height: 6).opacity(isFocusModeOn ? 1 : 0)
                    Text(isFocusModeOn ? "Focus Mode ON • Ends in 25m" : "Focus Mode OFF")
                        .font(.caption).bold()
                        .foregroundColor(.primaryGreen)
                }
            }

            Spacer()

            Toggle("", isOn: $isFocusModeOn).tint(.primaryGreen)
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(16)
    }
}

private struct QuickActionsGrid: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Quick Actions").font(.headline).bold()
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                QuickActionCard(title: "Work Mode", subtitle: "Block distractions", iconName: "briefcase.fill", color: .orange)
                QuickActionCard(title: "Study Time", subtitle: "Timer: 45m", iconName: "book.fill", color: .blue)
                QuickActionCard(title: "Social Detox", subtitle: "Strict lock", iconName: "person.2.slash.fill", color: .pink)
                QuickActionCard(title: "Wind Down", subtitle: "Prepare for sleep", iconName: "bed.double.fill", color: .indigo)
            }
        }
    }
}

private struct QuickActionCard: View {
    let title: String, subtitle: String, iconName: String, color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: iconName)
                .padding(8)
                .background(color.opacity(0.2))
                .foregroundColor(color)
                .cornerRadius(8)
            Text(title).font(.caption).bold()
            Text(subtitle).font(.caption2).foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.surfaceDark)
        .cornerRadius(16)
    }
}

private struct UsageBreakdownSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Usage Breakdown").font(.headline).bold()
                Spacer()
                Button("View Reports") {}.font(.caption).bold().foregroundColor(.primaryGreen)
            }

            VStack(spacing: 16) {
                UsageRow(category: "Social Media", time: "1h 12m", progress: 0.45, color: .pink, icon: "app.gift.fill")
                UsageRow(category: "Productivity", time: "45m", progress: 0.30, color: .blue, icon: "rocket.fill")
                UsageRow(category: "Entertainment", time: "18m", progress: 0.15, color: .purple, icon: "gamecontroller.fill")
            }
            .padding()
            .background(Color.surfaceDark)
            .cornerRadius(16)
        }
    }
}

private struct UsageRow: View {
    let category: String, time: String, progress: Double, color: Color, icon: String

    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon).foregroundColor(color)
                Text(category).font(.caption).bold()
                Spacer()
                Text(time).font(.caption).foregroundColor(.gray)
            }
            ProgressView(value: progress).tint(color)
        }
    }
}

#Preview {
    DashboardView()
}
