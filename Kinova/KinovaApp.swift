//
//  KinovaApp.swift
//  Kinova
//
//  Created by Igor Camilo on 12.07.25.
//

import SwiftUI

@main
struct KinovaApp: App {
    var body: some Scene {
        WindowGroup {
            KinovaAppView()
        }
    }
}

private struct KinovaAppView: View {
    @State private var viewModel = RootViewModel()

    var body: some View {
        RootView(
            viewModel: viewModel
        )
        .task {
            await viewModel.load()
        }
    }
}
