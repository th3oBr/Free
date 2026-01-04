//
//  FocusMode.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import Foundation
import FamilyControls

struct FocusMode {
    let name: String
    let iconName: String
    var settings: FocusModeSettings
}

struct FocusModeSettings {
    var schedule: Schedule?
    var appLimits: [AppLimit]?
    var pickupLimit: Int?
    var flowSession: FlowSession?
}

struct Schedule {
    var startTime: Date
    var endTime: Date
    var days: Set<DayOfWeek>
}

struct AppLimit {
    var app: FamilyActivitySelection
    var timeLimit: TimeInterval // in seconds
}

struct FlowSession {
    var duration: TimeInterval // in seconds
    var breakTime: TimeInterval // in seconds
}

enum DayOfWeek: String, CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}
