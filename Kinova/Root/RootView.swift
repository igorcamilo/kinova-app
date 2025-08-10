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
        NavigationStack(path: $viewModel.moviesPath) {
          MoviesView().destination()
        }
      }
      Tab("TV Shows", systemImage: "tv", value: .tvShows) {
        NavigationStack(path: $viewModel.tvShowsPath) {
          TVShowsView().destination()
        }
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
}

#Preview {
  RootView()
}
