//
//  MovieDetailsView.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import SwiftUI
import TMDB

struct MovieDetailsView: View {
  let id: Movie.ID
  let title: String

  @State private var viewModel = MovieDetailsViewModel()

  private var carouselItems: [Movie] {
    viewModel.value?.similar?.results ?? []
  }

  var body: some View {
    BackdropContainer(path: viewModel.value?.backdropPath) {
      LazyVStack(alignment: .leading, spacing: 8) {
        if let overview = viewModel.value?.overview {
          Text(overview)
            .font(.body)
            .padding(.horizontal)
        }
        Spacer().frame(height: 8)
        CarouselView(title: "Similar Movies", items: carouselItems)
      }
      .padding(.vertical, 8)
    }
    .navigationTitle(viewModel.value?.title ?? title)
    .refreshable { await viewModel.load(id: id) }
    .onAppear { Task { await viewModel.load(id: id) } }
  }
}

#Preview {
  NavigationStack {
    MovieDetailsView(id: 569094, title: "Spider-Man: Across the Spider-Verse")
  }
}
