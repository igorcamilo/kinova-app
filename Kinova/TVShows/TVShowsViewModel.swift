//
//  TVShowsViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import Foundation
import Observation
import TMDB
import os

private let logger = Logger(subsystem: "com.igorcamilo.kinova", category: "TVShowsViewModel")

@MainActor
@Observable
final class TVShowsViewModel {
  let client: Client

  var airingToday: [CarouselItem] = []
  var onTheAir: [CarouselItem] = []
  var popular: [CarouselItem] = []
  var topRated: [CarouselItem] = []

  init(client: Client = .shared) {
    logger.debug("Initializing TVShowsViewModel")
    self.client = client
  }

  deinit {
    logger.debug("Deinitializing TVShowsViewModel")
  }

  func load(width: CGFloat) async {
    logger.debug("Loading TV shows")
    do {
      async let airingTodayMovies = client.tvShows(list: .airingToday)
      async let onTheAirMovies = client.tvShows(list: .onTheAir)
      async let popularMovies = client.tvShows(list: .popular)
      async let topRatedMovies = client.tvShows(list: .topRated)
      let images = try await client.configuration().images
      let size = images.size(width: width, from: \.posterSizes)
      airingToday = try await airingTodayMovies.results.map { tvShow in
        let url = size.flatMap { images.url(size: $0, path: tvShow.posterPath) }
        return CarouselItem(id: .tvShow(tvShow.id), imageURL: url, title: tvShow.name)
      }
      onTheAir = try await onTheAirMovies.results.map { tvShow in
        let url = size.flatMap { images.url(size: $0, path: tvShow.posterPath) }
        return CarouselItem(id: .tvShow(tvShow.id), imageURL: url, title: tvShow.name)
      }
      popular = try await popularMovies.results.map { tvShow in
        let url = size.flatMap { images.url(size: $0, path: tvShow.posterPath) }
        return CarouselItem(id: .tvShow(tvShow.id), imageURL: url, title: tvShow.name)
      }
      topRated = try await topRatedMovies.results.map { tvShow in
        let url = size.flatMap { images.url(size: $0, path: tvShow.posterPath) }
        return CarouselItem(id: .tvShow(tvShow.id), imageURL: url, title: tvShow.name)
      }
    } catch URLError.cancelled {
      logger.info("TV shows loading cancelled")
    } catch {
      logger.warning("Failed to load TV shows: \(error)")
    }
  }
}
