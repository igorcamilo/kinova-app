//
//  MoviesView.swift
//  Kinova
//
//  Created by Igor Camilo on 22.07.25.
//

import SwiftUI

struct MoviesView: View {
  @State private var viewModel = MoviesViewModel()

  var body: some View {
    ScrollView(.vertical) {
      VStack(spacing: 20) {
        ImageCarousel(title: "Trending Today", items: viewModel.trendingToday)
        ImageCarousel(title: "Trending This Week", items: viewModel.trendingThisWeek)
        ImageCarousel(title: "Now Playing", items: viewModel.nowPlaying)
        ImageCarousel(title: "Popular", items: viewModel.popular)
        ImageCarousel(title: "Top Rated", items: viewModel.topRated)
        ImageCarousel(title: "Upcoming", items: viewModel.upcoming)
      }
      .padding(.vertical)
    }
    .containerGeometry()
    .navigationTitle("Movies")
    .refreshable { await viewModel.load() }
    .onAppear { Task { await viewModel.load() } }
    #if os(macOS)
      .frame(minWidth: 375)
    #endif
  }
}

#Preview {
  NavigationStack {
    MoviesView()
  }
}
