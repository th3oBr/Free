//
//  ScreenTimeManager.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings
import Combine

class ScreenTimeManager: ObservableObject {
    static let shared = ScreenTimeManager()

    private let authorizationCenter = AuthorizationCenter.shared
    private let store = ManagedSettingsStore()

    @Published var authorizationStatus: AuthorizationStatus = .notDetermined

    private var cancellables = Set<AnyCancellable>()

    private init() {
        authorizationCenter.$authorizationStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newStatus in
                self?.authorizationStatus = newStatus
            }
            .store(in: &cancellables)
    }

    func requestAuthorization() {
        Task {
            do {
                try await authorizationCenter.requestAuthorization(for: .individual)
            } catch {
                // Handle the error here.
                print("Failed to request authorization: \(error)")
            }
        }
    }

    func applyRestrictions() {
        // To shield all applications, we shield the `.all` category token.
        // The property expects a Set of tokens.
        store.shield.applicationCategories = Set([.all])
    }

    func clearRestrictions() {
        store.clearAllSettings()
    }

    // MARK: - Device Activity Monitoring

    // We will need to set up a DeviceActivityMonitor extension to schedule activities.
    // This will be used to start and stop the focus modes.

    func startMonitoring() {
        // Start monitoring for device activity.
    }

    func stopMonitoring() {
        // Stop monitoring for device activity.
    }
}
