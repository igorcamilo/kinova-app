//
//  RootView.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import SwiftUI

struct RootView: View {
  @State private var viewModel = RootViewModel()

  var body: some View {
    TabView(selection: $viewModel.selectedTab) {
      Tab("Movies", systemImage: "film", value: .movies) {
        MoviesView()
      }
      Tab("TV Shows", systemImage: "tv", value: .tvShows) {
        TVShowsView()
      }
    }
    .tabViewStyle(.sidebarAdaptable)
  }
}

#Preview {
  RootView()
}
