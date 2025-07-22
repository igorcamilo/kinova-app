//
//  Client+Kinova.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import TMDB

extension Client {
    static let shared = Client(
        accessToken: KinovaSecrets.tmdbAccessToken
    )

    func posters(movieList: MovieList) async throws -> [PosterModel] {
        async let movies = try await self.movies(list: movieList)
        let configuration = try await self.configuration()
        return try await movies.results.map {
            let posterSize = configuration.images.posterSizes.last ?? "original"
            let posterURL = configuration.images.secureBaseURL.appending(path: posterSize + $0.posterPath)
            return PosterModel(id: .movie($0.id), posterURL: posterURL, title: $0.title)
        }
    }
}
