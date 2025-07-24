//
//  MovieDetailViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import Observation
import TMDB

@MainActor
@Observable
final class MovieDetailViewModel {
    let client: Client
    let id: Movie.ID

    init(client: Client = .shared, id: Movie.ID) {
        self.client = client
        self.id = id
    }

    func load() async {}
}

extension MovieDetailViewModel: Hashable {
    nonisolated static func == (lhs: MovieDetailViewModel, rhs: MovieDetailViewModel) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
