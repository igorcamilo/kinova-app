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

  var body: some View {
    BackdropContainer(path: viewModel.value?.backdropPath) {
      LazyVStack(alignment: .leading, spacing: 16) {
        if let overview = viewModel.value?.overview {
          Text(overview)
            .font(.body)
            .horizontalMargin()
        }
        TextCarousel(
          title: "Genres",
          items: viewModel.value?.genres
        )
        ImageCarousel(
          title: "Similar Movies",
          items: viewModel.value?.similar?.results
        )
      }
      .padding(.vertical, 16)
    }
    .containerGeometry()
    .navigationTitle(viewModel.value?.title ?? title)
    .refreshable { await viewModel.load(id: id) }
    .onAppear {
      Task { @MainActor in
        await viewModel.load(id: id)
      }
    }
  }
}

#Preview {
  @Previewable @State var configuration = Configuration()
  NavigationStack {
    MovieDetailsView(id: 569094, title: "Spider-Man: Across the Spider-Verse")
  }
  .environment(configuration)
}
