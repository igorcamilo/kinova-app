//
//  TVShowDetailsView.swift
//  Kinova
//
//  Created by Igor Camilo on 27.07.25.
//

import SwiftUI
import TMDB

struct TVShowDetailsView: View {
  let id: TVShow.ID
  let title: String

  @State private var viewModel = TVShowDetailsViewModel()

  private var overview: String? {
    viewModel.value?.overview
  }

  private var firstAirDate: String? {
    viewModel.value?.firstAirDate
  }

  private var lastAirDate: String? {
    viewModel.value?.lastAirDate
  }

  private var genres: [Genre]? {
    viewModel.value?.genres
  }

  private var similar: [TVShow]? {
    viewModel.value?.similar?.results
  }

  private var keywords: [Keyword]? {
    viewModel.value?.keywords?.results
  }

  var body: some View {
    BackdropContainer(path: viewModel.value?.backdropPath) {
      LazyVStack(alignment: .leading, spacing: 16) {
        OverviewSection(value: overview)
        DateSection(title: "First Air Date", value: firstAirDate)
        DateSection(title: "Last Air Date", value: lastAirDate)
        TextCarousel(title: "Genres", items: genres)
        ImageCarousel(title: "Similar TV Shows", items: similar)
        TextCarousel(title: "Keywords", items: keywords)
      }
      .padding(.vertical, 16)
    }
    .containerGeometry()
    .navigationTitle(viewModel.value?.name ?? title)
    .toolbarTitleDisplayMode(.inline)
    .refreshable { await viewModel.load(id: id) }
    .onAppear { Task { await viewModel.load(id: id) } }
  }
}

#Preview {
  let configuration = Configuration()
  NavigationStack {
    TVShowDetailsView(id: 94605, title: "Arcane")
  }
  .environment(configuration)
}
