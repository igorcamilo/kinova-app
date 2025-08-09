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

private let logger = Logger(
  subsystem: Constants.subsystem,
  category: #fileID
)

@MainActor @Observable final class MoviesViewModel {
  let client: TMDBClient

  private(set) var isLoading = false
  private(set) var trendingToday: [Movie] = []
  private(set) var trendingThisWeek: [Movie] = []
  private(set) var nowPlaying: [Movie] = []
  private(set) var popular: [Movie] = []
  private(set) var topRated: [Movie] = []
  private(set) var upcoming: [Movie] = []

  init(client: TMDBClient = .shared) {
    self.client = client
  }

  func load() async {
    if isLoading {
      return
    }
    isLoading = true
    defer { isLoading = false }
    await withTaskGroup { group in
      group.addTask(operation: loadTrendingToday)
    }
    await withTaskGroup { group in
      group.addTask(operation: loadTrendingThisWeek)
    }
    await withTaskGroup { group in
      group.addTask(operation: loadNowPlaying)
    }
    await withTaskGroup { group in
      group.addTask(operation: loadPopular)
    }
    await withTaskGroup { group in
      group.addTask(operation: loadTopRated)
    }
    await withTaskGroup { group in
      group.addTask(operation: loadUpcoming)
    }
  }

  private func loadTrendingToday() async {
    do {
      trendingToday = try await client.movies(list: .trending(.day)).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private func loadTrendingThisWeek() async {
    do {
      trendingThisWeek = try await client.movies(list: .trending(.week)).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private func loadNowPlaying() async {
    do {
      nowPlaying = try await client.movies(list: .nowPlaying).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private func loadPopular() async {
    do {
      popular = try await client.movies(list: .popular).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private func loadTopRated() async {
    do {
      topRated = try await client.movies(list: .topRated).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private func loadUpcoming() async {
    do {
      upcoming = try await client.movies(list: .upcoming).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }
}
