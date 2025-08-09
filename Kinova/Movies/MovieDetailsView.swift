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

  @State private var viewModel = MovieDetailsViewModel()

  private var carouselItems: [Movie] {
    viewModel.value?.similar?.results ?? []
  }

  var body: some View {
    BackdropContainer(path: viewModel.value?.backdropPath) {
      LazyVStack(spacing: 20) {
        Spacer().frame(height: 20)
        CarouselView(title: "Similar", items: carouselItems)
      }
    }
    #if os(macOS)
      .navigationTitle("TV Show Details")
    #endif
    .refreshable { await viewModel.load(id: id) }
    .onAppear { Task { await viewModel.load(id: id) } }
  }
}

#Preview {
  NavigationStack {
    MovieDetailsView(id: 569094)
  }
}
