//
//  ScheduleModeView.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import SwiftUI

struct ScheduleModeView: View {
    @State private var modeName: String = "Work Focus"
    @State private var selectedTime: Date = Date()
    @State private var selectedDays: Set<String> = ["M", "T", "W", "T", "F"]
    @State private var isStrict = false
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            Color(red: 16/255, green: 34/255, blue: 22/255).ignoresSafeArea()

            VStack(spacing: 0) {
                HeaderView()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        ModeNameInput(modeName: $modeName)
                        TimeSchedulerSection(selectedTab: $selectedTab, selectedTime: $selectedTime)
                        DaySelector(selectedDays: $selectedDays)
                        ConfigurationSection(isStrict: $isStrict)
                        InfoAndActions()
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
            Button(action: {}) {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.white)
            }
            Spacer()
            Text("Zeitplan-Modus").bold()
            Spacer()
            Button("Save") {}.bold()
        }
        .padding()
        .foregroundColor(.primaryGreen)
        .background(Color.backgroundDark.opacity(0.8))
    }
}

private struct ModeNameInput: View {
    @Binding var modeName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Mode Name")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray)
                .textCase(.uppercase)

            HStack {
                TextField("e.g. Work, Sleep, Study", text: $modeName)
                    .font(.system(size: 18, weight: .medium))
                Image(systemName: "pencil")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.surfaceDark)
            .cornerRadius(12)
        }
    }
}

private struct TimeSchedulerSection: View {
    @Binding var selectedTab: Int
    @Binding var selectedTime: Date

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundColor(.primaryGreen)
                Text("Schedule").bold()
                Spacer()
            }
            .padding(.bottom)

            Picker("Time", selection: $selectedTab) {
                Text("Start Time").tag(0)
                Text("End Time").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.black.opacity(0.4))
            .cornerRadius(8)

            DatePicker(
                "Time",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            .colorInvert()
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(16)
    }
}

private struct DaySelector: View {
    @Binding var selectedDays: Set<String>
    let days = ["M", "T", "W", "T", "F", "S", "S"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Repeats")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray)
                .textCase(.uppercase)

            HStack {
                ForEach(days.indices, id: \.self) { index in
                    let day = days[index]
                    Button(action: {
                        if selectedDays.contains(day) {
                            selectedDays.remove(day)
                        } else {
                            selectedDays.insert(day)
                        }
                    }) {
                        Text(day)
                            .bold()
                            .frame(width: 40, height: 40)
                            .background(selectedDays.contains(day) ? Color.primaryGreen : Color.white.opacity(0.05))
                            .foregroundColor(selectedDays.contains(day) ? .backgroundDark : .gray)
                            .clipShape(Circle())
                    }
                }
            }
            .padding()
            .background(Color.surfaceDark)
            .cornerRadius(16)
        }
    }
}

private struct ConfigurationSection: View {
    @Binding var isStrict: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Configuration")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.gray)
                .textCase(.uppercase)

            VStack(spacing: 12) {
                BlockedAppsCard()
                StrictModeCard(isStrict: $isStrict)
            }
        }
    }
}

private struct BlockedAppsCard: View {
    var body: some View {
        HStack {
            Image(systemName: "square.grid.3x3.fill")
                .frame(width: 40, height: 40)
                .background(Color.indigo.opacity(0.2))
                .foregroundColor(.indigo)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text("Blocked Apps").bold()
                Text("Social Media, Games...").font(.caption).foregroundColor(.gray)
            }

            Spacer()

            HStack(spacing: -10) {
                Circle().fill(Color.blue).frame(width: 24, height: 24)
                Circle().fill(Color.pink).frame(width: 24, height: 24)
                Text("+2").font(.caption).frame(width: 24, height: 24).background(Color.gray).clipShape(Circle())
            }

            Image(systemName: "chevron.right").foregroundColor(.gray)
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(16)
    }
}

private struct StrictModeCard: View {
    @Binding var isStrict: Bool

    var body: some View {
        HStack {
            Image(systemName: "lock.fill")
                .frame(width: 40, height: 40)
                .background(Color.orange.opacity(0.2))
                .foregroundColor(.orange)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text("Strict Mode").bold()
                Text("Prevents changes while active").font(.caption).foregroundColor(.gray)
            }

            Spacer()

            Toggle("", isOn: $isStrict)
                .tint(.primaryGreen)
        }
        .padding()
        .background(Color.surfaceDark)
        .cornerRadius(16)
    }
}

private struct InfoAndActions: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: "info.circle")
                Text("During this scheduled time, notifications will be silenced and selected apps will be grayed out to help you focus.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()

            Button(action: {}) {
                HStack {
                    Image(systemName: "trash")
                    Text("Delete Schedule")
                }
                .foregroundColor(.red)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red.opacity(0.1))
            .cornerRadius(16)
        }
    }
}

#Preview {
    ScheduleModeView()
}
