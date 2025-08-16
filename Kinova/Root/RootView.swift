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
      Tab("Movies", systemImage: "film", value: .movies) {
        moviesView
      }
      Tab("TV Shows", systemImage: "tv", value: .tvShows) {
        tvShowsView
      }
    }
    .tabViewStyle(.sidebarAdaptable)
    .onAppear { viewModel.restoreData(from: state) }
    .onChange(of: scenePhase) {
      switch $1 {
      case .inactive:
        state = viewModel.restorationData()
      case .active, .background:
        break
      @unknown default:
        break
      }
    }
  }

  private var moviesView: some View {
    NavigationStack(path: $viewModel.moviesPath) {
      MoviesView().destination()
    }
  }

  private var tvShowsView: some View {
    NavigationStack(path: $viewModel.tvShowsPath) {
      TVShowsView().destination()
    }
  }
}

#Preview {
  let configuration = Configuration()
  RootView().environment(configuration)
}
