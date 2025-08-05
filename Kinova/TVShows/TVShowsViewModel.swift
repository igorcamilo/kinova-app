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
  let client: TMDBClient

  var trendingToday: [CarouselItem] = []
  var trendingThisWeek: [CarouselItem] = []
  var airingToday: [CarouselItem] = []
  var onTheAir: [CarouselItem] = []
  var popular: [CarouselItem] = []
  var topRated: [CarouselItem] = []

  init(client: TMDBClient = .shared) {
    logger.debug("Initializing TVShowsViewModel")
    self.client = client
  }

  deinit {
    logger.debug("Deinitializing TVShowsViewModel")
  }

  func load(width: CGFloat) async {
    logger.debug("Loading TV shows")
    do {
      async let trendingTodayTVShows = client.tvShows(list: .trending(.day))
      async let trendingThisWeekTVShows = client.tvShows(list: .trending(.week))
      async let airingTodayTVShows = client.tvShows(list: .airingToday)
      async let onTheAirTVShows = client.tvShows(list: .onTheAir)
      async let popularTVShows = client.tvShows(list: .popular)
      async let topRatedTVShows = client.tvShows(list: .topRated)
      let images = try await client.configuration().images
      let size = images.size(width: width, from: \.posterSizes)
      func mapTVShow(_ tvShow: TVShow) throws -> CarouselItem {
        let url = size.flatMap { images.url(size: $0, path: tvShow.posterPath) }
        return CarouselItem(id: .tvShow(tvShow.id), imageURL: url, title: tvShow.name)
      }
      trendingToday = try await trendingTodayTVShows.results.map(mapTVShow)
      trendingThisWeek = try await trendingThisWeekTVShows.results.map(mapTVShow)
      airingToday = try await airingTodayTVShows.results.map(mapTVShow)
      onTheAir = try await onTheAirTVShows.results.map(mapTVShow)
      popular = try await popularTVShows.results.map(mapTVShow)
      topRated = try await topRatedTVShows.results.map(mapTVShow)
    } catch URLError.cancelled {
      logger.info("TV shows loading cancelled")
    } catch {
      logger.warning("Failed to load TV shows: \(error)")
    }
  }
}
