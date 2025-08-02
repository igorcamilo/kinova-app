//
//  TVShowsView.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import SwiftUI

struct TVShowsView: View {
  @State private var viewModel = TVShowsViewModel()

  @Environment(\.carouselItemSize) private var carouselItemSize

  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 20) {
        CarouselView(
          title: "Airing Today",
          items: viewModel.airingToday,
        )
        CarouselView(
          title: "On The Air",
          items: viewModel.onTheAir,
        )
        CarouselView(
          title: "Popular",
          items: viewModel.popular,
        )
        CarouselView(
          title: "Top Rated",
          items: viewModel.topRated,
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
    .navigationTitle("TV Shows")
  }
}

#Preview {
  NavigationStack {
    TVShowsView()
  }
}
