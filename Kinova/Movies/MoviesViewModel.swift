//
//  MoviesViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 22.07.25.
//

import Foundation
import Observation
import TMDB
import os

private let logger = Logger(subsystem: "com.igorcamilo.kinova", category: "MoviesViewModel")

@MainActor
@Observable
final class MoviesViewModel {
  let client: Client

  var nowPlaying: [CarouselItem] = []
  var popular: [CarouselItem] = []
  var topRated: [CarouselItem] = []
  var upcoming: [CarouselItem] = []

  init(client: Client = .shared) {
    logger.debug("Initializing MoviesViewModel")
    self.client = client
  }

  deinit {
    logger.debug("Deinitializing MoviesViewModel")
  }

  func load(width: CGFloat) async {
    logger.debug("Loading movies")
    do {
      async let nowPlayingMovies = client.movies(list: .nowPlaying)
      async let popularMovies = client.movies(list: .popular)
      async let topRatedMovies = client.movies(list: .topRated)
      async let upcomingMovies = client.movies(list: .upcoming)
      let images = try await client.configuration().images
      let size = images.size(width: width, from: \.posterSizes)
      nowPlaying = try await nowPlayingMovies.results.map { movie in
        let url = size.flatMap { images.url(size: $0, path: movie.posterPath) }
        return CarouselItem(id: .movie(movie.id), imageURL: url, title: movie.title)
      }
      popular = try await popularMovies.results.map { movie in
        let url = size.flatMap { images.url(size: $0, path: movie.posterPath) }
        return CarouselItem(id: .movie(movie.id), imageURL: url, title: movie.title)
      }
      topRated = try await topRatedMovies.results.map { movie in
        let url = size.flatMap { images.url(size: $0, path: movie.posterPath) }
        return CarouselItem(id: .movie(movie.id), imageURL: url, title: movie.title)
      }
      upcoming = try await upcomingMovies.results.map { movie in
        let url = size.flatMap { images.url(size: $0, path: movie.posterPath) }
        return CarouselItem(id: .movie(movie.id), imageURL: url, title: movie.title)
      }
    } catch URLError.cancelled {
      logger.info("Movies loading cancelled")
    } catch {
      logger.warning("Failed to load movies: \(error)")
    }
  }
}
