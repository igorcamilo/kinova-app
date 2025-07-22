//
//  MoviesView.swift
//  Kinova
//
//  Created by Igor Camilo on 22.07.25.
//

import SwiftUI

struct MoviesView: View {
    let viewModel: MoviesViewModel

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading) {
                    Text("Now Playing")
                        .font(.title)
                        .padding(.horizontal)
                    PosterCarousel(posters: viewModel.nowPlaying)
                        .task { await viewModel.getNowPlaying() }
                    Text("Popular")
                        .font(.title)
                        .padding(.horizontal)
                    PosterCarousel(posters: viewModel.popular)
                        .task { await viewModel.getPopular() }
                    Text("Top Rated")
                        .font(.title)
                        .padding(.horizontal)
                    PosterCarousel(posters: viewModel.topRated)
                        .task { await viewModel.getTopRated() }
                    Text("Upcoming")
                        .font(.title)
                        .padding(.horizontal)
                    PosterCarousel(posters: viewModel.upcoming)
                        .task { await viewModel.getUpcoming() }
                }
                .padding(.vertical)
            }
            .navigationTitle("Movies")
        }
    }
}

#Preview {
    MoviesView(viewModel: MoviesViewModel())
}
