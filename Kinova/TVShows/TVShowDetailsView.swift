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

  private var carouselItems: [TVShow] {
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
        CarouselView(title: "Similar TV Shows", items: carouselItems)
      }
      .padding(.vertical, 8)
    }
    .navigationTitle(viewModel.value?.name ?? title)
    .refreshable { await viewModel.load(id: id) }
    .onAppear { Task { await viewModel.load(id: id) } }
  }
}

#Preview {
  NavigationStack {
    TVShowDetailsView(id: 94605, title: "Arcane")
  }
}
