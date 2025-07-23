//
//  RootView.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import SwiftUI

struct RootView: View {
    @Bindable var viewModel: RootViewModel

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            Tab("Movies", systemImage: "film", value: .movies) {
                MoviesView(viewModel: viewModel.moviesViewModel)
            }
            Tab("TV Shows", systemImage: "tv", value: .tvShows) {
                TVShowsView(viewModel: viewModel.tvShowsViewModel)
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    RootView(viewModel: RootViewModel())
}
