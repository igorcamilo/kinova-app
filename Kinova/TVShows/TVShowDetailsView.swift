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

  @State private var viewModel = TVShowDetailsViewModel()

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
    TVShowDetailsView(id: 94605)
  }
}
