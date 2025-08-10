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
          title: "Similar TV Shows",
          items: viewModel.value?.similar?.results
        )
      }
      .padding(.vertical, 16)
    }
    .containerGeometry()
    .navigationTitle(viewModel.value?.name ?? title)
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
    TVShowDetailsView(id: 94605, title: "Arcane")
  }
  .environment(configuration)
}
