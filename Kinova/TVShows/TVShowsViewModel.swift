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

private let logger = Logger(
  subsystem: Constants.subsystem,
  category: #fileID
)

@MainActor @Observable final class TVShowsViewModel {
  let client: TMDBClient

  private(set) var isLoading = false
  private(set) var trendingToday: [TVShow]?
  private(set) var trendingThisWeek: [TVShow]?
  private(set) var airingToday: [TVShow]?
  private(set) var onTheAir: [TVShow]?
  private(set) var popular: [TVShow]?
  private(set) var topRated: [TVShow]?

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
      group.addTask(operation: loadTrendingThisWeek)
      group.addTask(operation: loadAiringToday)
      group.addTask(operation: loadOnTheAir)
      group.addTask(operation: loadPopular)
      group.addTask(operation: loadTopRated)
    }
  }

  private func loadTrendingToday() async {
    do {
      trendingToday = try await client.tvShows(list: .trending(.day)).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private func loadTrendingThisWeek() async {
    do {
      trendingThisWeek = try await client.tvShows(list: .trending(.week)).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private func loadAiringToday() async {
    do {
      airingToday = try await client.tvShows(list: .airingToday).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private func loadOnTheAir() async {
    do {
      onTheAir = try await client.tvShows(list: .onTheAir).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private func loadPopular() async {
    do {
      popular = try await client.tvShows(list: .popular).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private func loadTopRated() async {
    do {
      topRated = try await client.tvShows(list: .topRated).results
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }
}
