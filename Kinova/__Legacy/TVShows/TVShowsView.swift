//
//  TVShowsView.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import SwiftUI

struct TVShowsView: View {
  @State private var viewModel = TVShowsViewModel()

  var body: some View {
    ScrollView(.vertical) {
      VStack(spacing: 20) {
        ImageCarousel(title: "Trending Today", items: viewModel.trendingToday)
        ImageCarousel(title: "Trending This Week", items: viewModel.trendingThisWeek)
        ImageCarousel(title: "Airing Today", items: viewModel.airingToday)
        ImageCarousel(title: "On The Air", items: viewModel.onTheAir)
        ImageCarousel(title: "Popular", items: viewModel.popular)
        ImageCarousel(title: "Top Rated", items: viewModel.topRated)
      }
      .padding(.vertical)
    }
    .containerGeometry()
    .navigationTitle("TV Shows")
    #if !os(tvOS)
      .toolbarTitleDisplayMode(.inlineLarge)
    #endif
    .refreshable { await viewModel.load() }
    .onAppear {
      Task {
        await viewModel.load()
      }
    }
    #if os(macOS)
      .frame(minWidth: 375)
    #endif
  }
}

#Preview {
  let configuration = Configuration()
  NavigationStack {
    TVShowsView()
  }
  .environment(configuration)
}
