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

  private var carouselItems: [TVShow] {
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
    TVShowDetailsView(id: 94605)
  }
}
