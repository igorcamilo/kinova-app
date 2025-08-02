//
//  MovieDetailViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import Foundation
import Observation
import TMDB
import os

private let logger = Logger(subsystem: "com.igorcamilo.kinova", category: "MovieDetailViewModel")

@MainActor
@Observable
final class MovieDetailViewModel {
  let client: Client

  var similar: [CarouselItem] = []

  init(client: Client = .shared) {
    logger.debug("Initializing MovieDetailViewModel")
    self.client = client
  }

  deinit {
    logger.debug("Deinitializing MovieDetailViewModel")
  }

  func load(id: Movie.ID, width: CGFloat) async {
    logger.debug("Loading movie detail id: \(id.rawValue)")
    do {
      async let similarMovies = client.movies(list: .similar(id))
      let images = try await client.configuration().images
      let size = images.size(width: width, from: \.posterSizes)
      similar = try await similarMovies.results.map { movie in
        let url = size.flatMap { images.url(size: $0, path: movie.posterPath) }
        return CarouselItem(id: .movie(movie.id), imageURL: url, title: movie.title)
      }
    } catch URLError.cancelled {
      logger.info("Movie detail loading cancelled")
    } catch {
      logger.warning("Failed to load movie detail: \(error)")
    }
  }
}
