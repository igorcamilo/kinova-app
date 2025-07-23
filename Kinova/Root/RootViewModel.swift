//
//  RootViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import Observation
import TMDB

@MainActor
@Observable
final class RootViewModel {
    let client: Client

    let moviesViewModel: MoviesViewModel
    let tvShowsViewModel: TVShowsViewModel

    var selectedTab = Tab.movies {
        didSet {
            Task(name: "Tab Selected") {
                await loadSelectedTab()
            }
        }
    }

    init(client: Client = .shared) {
        self.client = client
        self.moviesViewModel = MoviesViewModel(client: client)
        self.tvShowsViewModel = TVShowsViewModel(client: client)
    }

    func load() async {
        await loadSelectedTab()
    }

    func loadSelectedTab() async {
        switch selectedTab {
        case .movies:
            await moviesViewModel.load()
        case .tvShows:
            await tvShowsViewModel.load()
        }
    }

    enum Tab: Codable, Hashable, Sendable {
        case movies
        case tvShows
    }
}
