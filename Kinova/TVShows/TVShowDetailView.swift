//
//  TVShowDetailView.swift
//  Kinova
//
//  Created by Igor Camilo on 27.07.25.
//

import SwiftUI
import TMDB

struct TVShowDetailView: View {
  let id: TVShow.ID

  @State private var viewModel = TVShowDetailViewModel()

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
    .navigationTitle("TV Show Detail \(id.rawValue)")
  }
}

#Preview {
  NavigationStack {
    let id = TVShow.ID(rawValue: 94605)
    TVShowDetailView(id: id)
  }
}
