//
//  MovieDetailView.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import SwiftUI
import TMDB

struct MovieDetailView: View {
  let id: Movie.ID

  @State private var viewModel = MovieDetailViewModel()

  @Environment(\.carouselItemSize) private var carouselItemSize

  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 20) {
        CarouselView(
          title: "Similar",
          items: viewModel.similar,
        )
      }
      .padding(.vertical)
    }
    .refreshable {
      await viewModel.load(id: id, width: carouselItemSize.width)
    }
    .task {
      await viewModel.load(id: id, width: carouselItemSize.width)
    }
    .navigationTitle("Movie Detail \(id.rawValue)")
  }
}

#Preview {
  NavigationStack {
    let id = Movie.ID(rawValue: 569094)
    MovieDetailView(id: id)
  }
}
