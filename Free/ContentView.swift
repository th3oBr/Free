//
//  ContentView.swift
//  Free
//
//  Created by Theo Bröll on 04.01.26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        if appViewModel.isOnboardingComplete {
            MainTabView()
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppViewModel())
}
