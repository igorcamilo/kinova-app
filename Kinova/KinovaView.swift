//
//  KinovaView.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import SwiftUI

struct KinovaView: View {
    @State private var viewModel = KinovaViewModel()

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            Tab("Movies", systemImage: "film", value: .movies) {
                MoviesView(viewModel: viewModel.moviesViewModel)
            }
            Tab("TV Shows", systemImage: "tv", value: .tvShows) {
                Text("TV Shows Tab")
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    KinovaView()
}
