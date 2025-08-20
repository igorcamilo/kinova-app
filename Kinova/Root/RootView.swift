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
