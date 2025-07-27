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

    let similar: CarouselViewModel

    var movieDetail: MovieDetailViewModel?

    init(client: Client = .shared, id: Movie.ID) {
        self.client = client
        self.id = id
        self.similar = CarouselViewModel(client: client, list: .movies(.similar(id)))
    }

    func load() async {
        await withTaskGroup { [similar] group in
            group.addTask {
                await similar.load()
            }
        }
    }

    func onListItemTap(id: CarouselViewModel.Item.ID) {
        switch id {
        case let .movie(id):
            let viewModel = MovieDetailViewModel(client: client, id: id)
            movieDetail = viewModel
            Task { await viewModel.load() }
        case .tvShow:
            break
        }
    }
}

extension MovieDetailViewModel: Hashable {
    nonisolated static func == (lhs: MovieDetailViewModel, rhs: MovieDetailViewModel) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
