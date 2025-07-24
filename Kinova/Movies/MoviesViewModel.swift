//
//  MoviesViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 22.07.25.
//

import Foundation
import Observation
import TMDB

@MainActor
@Observable
final class MoviesViewModel {
    let client: Client

    let nowPlaying: CarouselViewModel
    let popular: CarouselViewModel
    let topRated: CarouselViewModel
    let upcoming: CarouselViewModel

    var movieDetail: MovieDetailViewModel?

    init(client: Client = .shared) {
        self.client = client
        self.nowPlaying = CarouselViewModel(client: client, list: .movies(.nowPlaying))
        self.popular = CarouselViewModel(client: client, list: .movies(.popular))
        self.topRated = CarouselViewModel(client: client, list: .movies(.topRated))
        self.upcoming = CarouselViewModel(client: client, list: .movies(.upcoming))
    }

    func load() async {
        await withTaskGroup { [nowPlaying, popular, topRated, upcoming] group in
            group.addTask {
                await nowPlaying.load()
            }
            group.addTask {
                await popular.load()
            }
            group.addTask {
                await topRated.load()
            }
            group.addTask {
                await upcoming.load()
            }
        }
    }

    func onListItemTap(id: CarouselViewModel.Item.ID) {
        switch id {
        case let .movie(id):
            movieDetail = MovieDetailViewModel(client: client, id: id)
        case .tvShow:
            break
        }
    }
}
