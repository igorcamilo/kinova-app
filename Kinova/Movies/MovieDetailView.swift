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
                    viewModel: viewModel.similar,
                    action: viewModel.onListItemTap(id:)
                )
            }
            .padding(.vertical)
        }
        .refreshable {
            await withTaskGroup { group in
                group.addTask {
                    await viewModel.load()
                }
                group.addTask {
                    // If the real loading is too fast, we
                    // add a little extra time
                    try? await Task.sleep(for: .seconds(2))
                }
            }
        }
        .navigationTitle("Movie Detail \(viewModel.id.rawValue)")
        .navigationDestination(item: $viewModel.movieDetail) {
            MovieDetailView(viewModel: $0)
        }
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
