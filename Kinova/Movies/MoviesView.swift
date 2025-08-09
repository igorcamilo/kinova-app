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
      LazyVStack(spacing: 20) {
        CarouselView(title: "Trending Today", items: viewModel.trendingToday)
        CarouselView(title: "Trending This Week", items: viewModel.trendingThisWeek)
        CarouselView(title: "Now Playing", items: viewModel.nowPlaying)
        CarouselView(title: "Popular", items: viewModel.popular)
        CarouselView(title: "Top Rated", items: viewModel.topRated)
        CarouselView(title: "Upcoming", items: viewModel.upcoming)
      }
      .padding(.vertical)
    }
    .refreshable { await viewModel.load() }
    .onAppear { Task { await viewModel.load() } }
    .navigationTitle("Movies")
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
