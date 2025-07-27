//
//  TVShowDetailView.swift
//  Kinova
//
//  Created by Igor Camilo on 27.07.25.
//

import SwiftUI

struct TVShowDetailView: View {
    @Bindable var viewModel: TVShowDetailViewModel

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
        .navigationTitle("TV Show Detail \(viewModel.id.rawValue)")
        .navigationDestination(item: $viewModel.tvShowDetail) {
            TVShowDetailView(viewModel: $0)
        }
    }
}

#Preview {
    NavigationStack {
        TVShowDetailView(
            viewModel: TVShowDetailViewModel(
                id: .init(rawValue: 1)
            )
        )
    }
}
