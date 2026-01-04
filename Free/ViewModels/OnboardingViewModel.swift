//
//  OnboardingViewModel.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import Foundation
import Combine
import FamilyControls

class OnboardingViewModel: ObservableObject {
    private let screenTimeManager = ScreenTimeManager.shared

    @Published var authorizationStatus: AuthorizationStatus = .notDetermined

    private var cancellables = Set<AnyCancellable>()

    init() {
        screenTimeManager.$authorizationStatus
            .receive(on: DispatchQueue.main)
            .assign(to: \.authorizationStatus, on: self)
            .store(in: &cancellables)
    }

    func requestAuthorization() {
        screenTimeManager.requestAuthorization()
    }
}
