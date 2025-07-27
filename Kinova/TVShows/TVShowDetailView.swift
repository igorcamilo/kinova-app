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
            await viewModel.load()
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
