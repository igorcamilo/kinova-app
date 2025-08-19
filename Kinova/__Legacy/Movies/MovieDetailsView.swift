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

  private var overview: String? {
    viewModel.value?.overview
  }

  private var releaseDate: String? {
    viewModel.value?.releaseDate
  }

  private var genres: [Genre]? {
    viewModel.value?.genres
  }

  private var similar: [Movie]? {
    viewModel.value?.similar?.results
  }

  private var keywords: [Keyword]? {
    viewModel.value?.keywords?.keywords
  }

  var body: some View {
    BackdropContainer(path: viewModel.value?.backdropPath) {
      LazyVStack(alignment: .leading, spacing: 16) {
        OverviewSection(value: overview)
        DateSection(title: "Release Date", value: releaseDate)
        TextCarousel(title: "Genres", items: genres)
        ImageCarousel(title: "Similar Movies", items: similar)
        TextCarousel(title: "Keywords", items: keywords)
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
