//
//  AppViewModel.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import Foundation
import SwiftUI

class AppViewModel: ObservableObject {
    @AppStorage("isOnboardingComplete") var isOnboardingComplete: Bool = false

    func completeOnboarding() {
        isOnboardingComplete = true
    }
}
