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
    NavigationStack {
      ScrollView(.vertical) {
        LazyVStack(spacing: 20) {
          CarouselView(
            title: "Now Playing",
            viewModel: viewModel.nowPlaying,
            action: viewModel.onListItemTap(id:)
          )
          CarouselView(
            title: "Popular",
            viewModel: viewModel.popular,
            action: viewModel.onListItemTap(id:)
          )
          CarouselView(
            title: "Top Rated",
            viewModel: viewModel.topRated,
            action: viewModel.onListItemTap(id:)
          )
          CarouselView(
            title: "Upcoming",
            viewModel: viewModel.upcoming,
            action: viewModel.onListItemTap(id:)
          )
        }
        .padding(.vertical)
      }
      .refreshable {
        await viewModel.load()
      }
      .task {
        await viewModel.load()
      }
      .navigationTitle("Movies")
      .navigationDestination(item: $viewModel.movieDetail) {
        MovieDetailView(viewModel: $0)
      }
    }
  }
}

#Preview {
  MoviesView()
}
