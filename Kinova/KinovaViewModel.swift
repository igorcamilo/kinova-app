//
//  KinovaViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import Observation
import TMDB

@Observable
final class KinovaViewModel {
    let client: Client

    var selectedTab = Tab.movies

    init(client: Client = .default) {
        self.client = client
    }

    enum Tab: Codable, Hashable, Sendable {
        case movies
        case tvShows
    }
}
