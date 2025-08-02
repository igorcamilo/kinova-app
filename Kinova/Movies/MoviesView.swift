//
//  MoviesView.swift
//  Kinova
//
//  Created by Igor Camilo on 22.07.25.
//

import SwiftUI

struct MoviesView: View {
  @State private var viewModel = MoviesViewModel()

  @Environment(\.carouselItemSize) private var carouselItemSize

  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 20) {
        CarouselView(
          title: "Now Playing",
          items: viewModel.nowPlaying,
        )
        CarouselView(
          title: "Popular",
          items: viewModel.popular,
        )
        CarouselView(
          title: "Top Rated",
          items: viewModel.topRated,
        )
        CarouselView(
          title: "Upcoming",
          items: viewModel.upcoming,
        )
      }
      .padding(.vertical)
    }
    .refreshable {
      await viewModel.load(width: carouselItemSize.width)
    }
    .task {
      await viewModel.load(width: carouselItemSize.width)
    }
    .navigationTitle("Movies")
  }
}

#Preview {
  NavigationStack {
    MoviesView()
  }
}
