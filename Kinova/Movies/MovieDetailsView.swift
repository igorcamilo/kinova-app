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

  @Environment(\.posterSize) private var posterSize

  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 20) {
        PosterView(
          imageURL: viewModel.posterURL,
          caption: viewModel.title
        )
        .environment(\.posterSize, CGSize(width: 260, height: 390))
        CarouselView(
          title: "Similar",
          items: viewModel.similar,
        )
      }
      .padding(.vertical)
    }
    .refreshable {
      await viewModel.load(id: id, bigWidth: 260, smallWidth: posterSize.width)
    }
    .task {
      await viewModel.load(id: id, bigWidth: 260, smallWidth: posterSize.width)
    }
  }
}

#Preview {
  NavigationStack {
    MovieDetailsView(id: 569094)
  }
}
