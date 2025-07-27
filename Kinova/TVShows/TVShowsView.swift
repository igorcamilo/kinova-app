//
//  TVShowsView.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import SwiftUI

struct TVShowsView: View {
    @Bindable var viewModel: TVShowsViewModel

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 20) {
                    CarouselView(
                        title: "Airing Today",
                        viewModel: viewModel.airingToday,
                        action: viewModel.onListItemTap(id:)
                    )
                    CarouselView(
                        title: "On The Air",
                        viewModel: viewModel.onTheAir,
                        action: viewModel.onListItemTap(id:)
                    )
                    CarouselView(
                        title: "Popular",
                        viewModel: viewModel.popular,
                        action: viewModel.onListItemTap(id:)
                    )
                    CarouselView(
                        title: "Top Rated",
                        viewModel: viewModel.topRated,
                        action: viewModel.onListItemTap(id:)
                    )
                }
                .padding(.vertical)
            }
            .refreshable {
                await viewModel.load()
            }
            .navigationTitle("TV Shows")
            .navigationDestination(item: $viewModel.tvShowDetail) {
                TVShowDetailView(viewModel: $0)
            }
        }
    }
}

#Preview {
    TVShowsView(viewModel: TVShowsViewModel())
}
