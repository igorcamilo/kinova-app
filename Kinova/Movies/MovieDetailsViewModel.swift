//
//  MovieDetailsViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import Foundation
import Observation
import TMDB
import os

private let logger = Logger(subsystem: "com.igorcamilo.kinova", category: "MovieDetailsViewModel")

@MainActor
@Observable
final class MovieDetailsViewModel {
  let client: TMDBClient

  var posterURL: URL?
  var title: String?
  var similar: [CarouselItem] = []

  init(client: TMDBClient = .shared) {
    logger.debug("Initializing MovieDetailsViewModel")
    self.client = client
  }

  deinit {
    logger.debug("Deinitializing MovieDetailsViewModel")
  }

  func load(id: Movie.ID, bigWidth: CGFloat, smallWidth: CGFloat) async {
    logger.debug("Loading movie detail id: \(id.rawValue)")
    do {
      async let movieDetails = client.movieDetails(id: id)
      let images = try await client.configuration().images
      let bigSize = images.size(width: bigWidth, from: \.posterSizes)
      let smallSize = images.size(width: smallWidth, from: \.posterSizes)
      if let bigSize {
        posterURL = images.url(size: bigSize, path: try await movieDetails.posterPath)
      }
      title = try await movieDetails.title
      if let similarMovies = try await movieDetails.similar {
        similar = similarMovies.results.map { movie in
          let url = smallSize.flatMap { images.url(size: $0, path: movie.posterPath) }
          return CarouselItem(id: .movie(movie.id), imageURL: url, title: movie.title)
        }
      }
    } catch URLError.cancelled {
      logger.info("Movie detail loading cancelled")
    } catch {
      logger.warning("Failed to load movie detail: \(error)")
    }
  }
}
