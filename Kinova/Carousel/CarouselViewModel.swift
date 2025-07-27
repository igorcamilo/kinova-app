//
//  CarouselViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import Foundation
import Observation
import os
import TMDB

private let logger = Logger()

@MainActor
@Observable
final class CarouselViewModel {
    let client: Client
    let list: List

    var state = State.placeholder

    private var isLoading = false

    init(client: Client = .shared, list: List) {
        self.client = client
        self.list = list
    }

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let items = switch list {
            case let .movies(movieList):
                try await items(movieList: movieList)
            case let .tvShows(tvShowList):
                try await items(tvShowList: tvShowList)
            }
            state = .loaded(items)
        } catch URLError.cancelled {
            logger.debug("Carousel loading cancelled")
        } catch {
            logger.error("Carousel loading failed: \(error)")
        }
    }

    private func items(movieList: MovieList) async throws -> [Item] {
        async let movies = client.movies(list: movieList)
        let baseURL = try await basePosterURL()
        return try await movies.results.map {
            let url = $0.posterPath.map { baseURL.appending(path: $0) }
            return Item(id: .movie($0.id), imageURL: url, title: $0.title)
        }
    }

    private func items(tvShowList: TVShowList) async throws -> [Item] {
        async let movies = client.tvShows(list: tvShowList)
        let baseURL = try await basePosterURL()
        return try await movies.results.map {
            let url = $0.posterPath.map { baseURL.appending(path: $0) }
            return Item(id: .tvShow($0.id), imageURL: url, title: $0.name)
        }
    }

    private func basePosterURL() async throws -> URL {
        let configuration = try await client.configuration()
        let posterSize = "w500" // FIXME: configuration.images.posterSizes
        return configuration.images.secureBaseURL.appending(path: posterSize)
    }

    struct Item: Codable, Hashable, Identifiable, Sendable {
        var id: ID
        var imageURL: URL?
        var title: String

        enum ID: Codable, Hashable, Sendable {
            case movie(Movie.ID)
            case tvShow(TVShow.ID)
        }
    }

    enum List: Codable, Hashable, Sendable {
        case movies(MovieList)
        case tvShows(TVShowList)
    }

    enum State: Codable, Hashable, Sendable {
        case loaded([Item])
        case placeholder
    }
}
