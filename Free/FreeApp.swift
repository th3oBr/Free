//
//  FreeApp.swift
//  Free
//
//  Created by Theo Bröll on 04.01.26.
//

import SwiftUI

@main
struct FreeApp: App {
    @StateObject private var appViewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appViewModel)
        }
    }
}
