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
  let client: TMDBClient

  var trendingToday: [CarouselItem] = []
  var trendingThisWeek: [CarouselItem] = []
  var nowPlaying: [CarouselItem] = []
  var popular: [CarouselItem] = []
  var topRated: [CarouselItem] = []
  var upcoming: [CarouselItem] = []

  init(client: TMDBClient = .shared) {
    logger.debug("Initializing MoviesViewModel")
    self.client = client
  }

  deinit {
    logger.debug("Deinitializing MoviesViewModel")
  }

  func load(width: CGFloat) async {
    logger.debug("Loading movies")
    do {
      async let trendingTodayMovies = client.movies(list: .trending(.day))
      async let trendingThisWeekMovies = client.movies(list: .trending(.week))
      async let nowPlayingMovies = client.movies(list: .nowPlaying)
      async let popularMovies = client.movies(list: .popular)
      async let topRatedMovies = client.movies(list: .topRated)
      async let upcomingMovies = client.movies(list: .upcoming)
      let images = try await client.configuration().images
      let size = images.size(width: width, from: \.posterSizes)
      func mapMovie(_ movie: Movie) throws -> CarouselItem {
        let url = size.flatMap { images.url(size: $0, path: movie.posterPath) }
        return CarouselItem(id: .movie(movie.id), imageURL: url, title: movie.title)
      }
      trendingToday = try await trendingTodayMovies.results.map(mapMovie)
      trendingThisWeek = try await trendingThisWeekMovies.results.map(mapMovie)
      nowPlaying = try await nowPlayingMovies.results.map(mapMovie)
      popular = try await popularMovies.results.map(mapMovie)
      topRated = try await topRatedMovies.results.map(mapMovie)
      upcoming = try await upcomingMovies.results.map(mapMovie)
    } catch URLError.cancelled {
      logger.info("Movies loading cancelled")
    } catch {
      logger.warning("Failed to load movies: \(error)")
    }
  }
}
