//
//  TVShowsViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import Foundation
import Observation
import TMDB

@MainActor
@Observable
final class TVShowsViewModel {
    let client: Client

    let airingToday: CarouselViewModel
    let onTheAir: CarouselViewModel
    let popular: CarouselViewModel
    let topRated: CarouselViewModel

    init(client: Client = .shared) {
        self.client = client
        self.airingToday = CarouselViewModel(client: client, list: .tvShows(.airingToday))
        self.onTheAir = CarouselViewModel(client: client, list: .tvShows(.onTheAir))
        self.popular = CarouselViewModel(client: client, list: .tvShows(.popular))
        self.topRated = CarouselViewModel(client: client, list: .tvShows(.topRated))
    }

    func load() async {
        await withTaskGroup { [airingToday, onTheAir, popular, topRated] group in
            group.addTask(name: "TV Shows: Airing Today") {
                await airingToday.load()
            }
            group.addTask(name: "TV Shows: On The Air") {
                await onTheAir.load()
            }
            group.addTask(name: "TV Shows: Popular") {
                await popular.load()
            }
            group.addTask(name: "TV Shows: Top Rated") {
                await topRated.load()
            }
        }
    }

    func onListItemTap(id: CarouselViewModel.Item.ID) {}
}
