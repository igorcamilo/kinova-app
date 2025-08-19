//
//  RootView.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import SwiftUI

struct RootView: View {
  @Environment(\.scenePhase) private var scenePhase
  @SceneStorage("state") private var state: Data?
  @State private var viewModel = RootViewModel()

  var body: some View {
    TabView(selection: $viewModel.selectedTab) {
      Tab("Home", systemImage: "play.house", value: .home) {
        homeView
      }
      Tab("Lists", systemImage: "list.bullet.rectangle", value: .lists) {
        listsView
      }
      Tab("Movies", systemImage: "film", value: .movies) {
        moviesView
      }
      Tab("TV Shows", systemImage: "tv", value: .tvShows) {
        tvShowsView
      }
      Tab(value: .search, role: .search) {
        searchView.searchable(text: $viewModel.searchText)
      }
    }
    .tabViewStyle(.sidebarAdaptable)
    .onAppear {
      viewModel.restoreData(from: state)
    }
    .onChange(of: scenePhase) {
      if scenePhase == .inactive {
        state = viewModel.restorationData()
      }
    }
  }

  private var homeView: some View {
    NavigationStack(path: $viewModel.homePath) {
      Button("Home View") {}
        .navigationTitle("Home")
        .toolbarTitleDisplayMode(.inlineLarge)
    }
  }

  private var listsView: some View {
    NavigationStack(path: $viewModel.listsPath) {
      Button("Lists View") {}
        .navigationTitle("Lists")
        .toolbarTitleDisplayMode(.inlineLarge)
    }
  }

  private var moviesView: some View {
    NavigationStack(path: $viewModel.moviesPath) {
      Button("Movies View") {}
        .navigationTitle("Movies")
        .toolbarTitleDisplayMode(.inlineLarge)
    }
  }

  private var tvShowsView: some View {
    NavigationStack(path: $viewModel.tvShowsPath) {
      Button("TV Shows View") {}
        .navigationTitle("TV Shows")
        .toolbarTitleDisplayMode(.inlineLarge)
    }
  }

  private var searchView: some View {
    NavigationStack(path: $viewModel.searchPath) {
      Button("Search View") {}
        .navigationTitle("Search")
        .toolbarTitleDisplayMode(.inlineLarge)
    }
  }
}

#Preview {
  RootView()
}
