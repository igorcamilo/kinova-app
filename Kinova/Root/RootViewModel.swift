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

    var selectedTab = Tab.movies

    init(client: Client = .shared) {
        self.client = client
        self.moviesViewModel = MoviesViewModel(client: client)
    }

    func load() async {
        await moviesViewModel.load()
    }

    enum Tab: Codable, Hashable, Sendable {
        case movies
        case tvShows
    }
}
