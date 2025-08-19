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
        searchView
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
      Text("Home View")
        #if !os(tvOS)
          .navigationTitle("Home")
          .toolbarTitleDisplayMode(.inlineLarge)
        #endif
    }
  }

  private var listsView: some View {
    NavigationStack(path: $viewModel.listsPath) {
      Text("Lists View")
        #if !os(tvOS)
          .navigationTitle("Lists")
          .toolbarTitleDisplayMode(.inlineLarge)
        #endif
    }
  }

  private var moviesView: some View {
    NavigationStack(path: $viewModel.moviesPath) {
      Text("Movies View")
        #if !os(tvOS)
          .navigationTitle("Movies")
          .toolbarTitleDisplayMode(.inlineLarge)
        #endif
    }
  }

  private var tvShowsView: some View {
    NavigationStack(path: $viewModel.tvShowsPath) {
      Text("TV Shows View")
        #if !os(tvOS)
          .navigationTitle("TV Shows")
          .toolbarTitleDisplayMode(.inlineLarge)
        #endif
    }
  }

  private var searchView: some View {
    NavigationStack(path: $viewModel.searchPath) {
      Text("Search View")
        #if !os(tvOS)
          .navigationTitle("Search")
          .toolbarTitleDisplayMode(.inlineLarge)
        #endif
    }
  }
}

#Preview {
  RootView()
}
