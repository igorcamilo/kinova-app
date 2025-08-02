//
//  MovieDetailView.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import SwiftUI

struct MovieDetailView: View {
  @Bindable var viewModel: MovieDetailViewModel

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
      await viewModel.load()
    }
    .navigationTitle("Movie Detail \(viewModel.id.rawValue)")
  }
}

#Preview {
  NavigationStack {
    MovieDetailView(
      viewModel: MovieDetailViewModel(
        id: .init(rawValue: 1)
      )
    )
  }
}
