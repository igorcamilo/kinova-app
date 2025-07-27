//
//  TVShowDetailViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 27.07.25.
//

import Observation
import TMDB

@MainActor
@Observable
final class TVShowDetailViewModel {
    let client: Client
    let id: TVShow.ID

    let similar: CarouselViewModel

    var tvShowDetail: TVShowDetailViewModel?

    init(client: Client = .shared, id: TVShow.ID) {
        self.client = client
        self.id = id
        self.similar = CarouselViewModel(client: client, list: .tvShows(.similar(id)))
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
        case let .tvShow(id):
            let viewModel = TVShowDetailViewModel(client: client, id: id)
            tvShowDetail = viewModel
            Task { await viewModel.load() }
        case .movie:
            break
        }
    }
}

extension TVShowDetailViewModel: Hashable {
    nonisolated static func == (lhs: TVShowDetailViewModel, rhs: TVShowDetailViewModel) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
