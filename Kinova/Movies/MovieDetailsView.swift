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

  private var genres: [Genre]? {
    viewModel.value?.genres
  }

  private var similar: [Movie]? {
    viewModel.value?.similar?.results
  }

  var body: some View {
    BackdropContainer(path: viewModel.value?.backdropPath) {
      LazyVStack(alignment: .leading, spacing: 16) {
        if let overview = viewModel.value?.overview {
          Text(overview)
            .font(.body)
            .horizontalMargin()
        }
        TextCarousel(title: "Genres", items: genres)
        ImageCarousel(title: "Similar Movies", items: similar)
      }
      .padding(.vertical, 16)
    }
    .containerGeometry()
    .navigationTitle(viewModel.value?.title ?? title)
    .toolbarTitleDisplayMode(.inline)
    .refreshable { await viewModel.load(id: id) }
    .onAppear { Task { await viewModel.load(id: id) } }
  }
}

#Preview {
  let configuration = Configuration()
  NavigationStack {
    MovieDetailsView(id: 569094, title: "Spider-Man: Across the Spider-Verse")
  }
  .environment(configuration)
}
