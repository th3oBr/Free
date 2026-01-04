//
//  MainTabView.swift
//  Free
//
//  Created by Theo Bröll on 2024-01-04.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .dashboard

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "square.grid.2x2.fill")
                    }
                    .tag(Tab.dashboard)

                ModeSelectionView()
                    .tabItem {
                        Label("Modes", systemImage: "square.stack.3d.up.fill")
                    }
                    .tag(Tab.modes)

                Text("Statistics")
                    .tabItem {
                        Label("Statistics", systemImage: "chart.bar.fill")
                    }
                    .tag(Tab.stats)

                Text("Profile")
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(Tab.profile)
            }
            .navigationTitle(navigationTitle(for: selectedTab))
            .navigationBarHidden(selectedTab == .dashboard) // Hide for custom header
        }
    }

    private func navigationTitle(for tab: Tab) -> String {
        switch tab {
        case .dashboard: return "Dashboard"
        case .modes: return "Modes"
        case .stats: return "Statistics"
        case .profile: return "Profile"
        }
    }
}

#Preview {
    MainTabView()
}
