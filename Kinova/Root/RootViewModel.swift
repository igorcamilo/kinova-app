//
//  RootViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import Foundation
import Observation
import TMDB
import os

private let decoder = JSONDecoder()
private let encoder = JSONEncoder()

private let logger = Logger(
  subsystem: Constants.subsystem,
  category: #fileID
)

@Observable final class RootViewModel {
  var homePath: [Destination] = []
  var listsPath: [Destination] = []
  var moviesPath: [Destination] = []
  var tvShowsPath: [Destination] = []
  var searchPath: [Destination] = []
  var selectedTab = Tab.home

  enum Tab: String, Codable, Hashable, Sendable {
    case home
    case lists
    case movies
    case tvShows
    case search
  }

  func restorationData() -> Data? {
    let value = RestorationData(
      homePath: homePath,
      listsPath: listsPath,
      moviesPath: moviesPath,
      tvShowsPath: tvShowsPath,
      searchPath: searchPath,
      selectedTab: selectedTab
    )
    logger.info("\(#function) creating restoration data: \(String(describing: value))")
    do {
      return try encoder.encode(value)
    } catch {
      logger.error("\(#function) error: \(error)")
      return nil
    }
  }

  func restoreData(from data: Data?) {
    guard let data else {
      logger.info("\(#function) exited: no data")
      return
    }
    do {
      let value = try decoder.decode(RestorationData.self, from: data)
      logger.info("\(#function) restoring from data: \(String(describing: value))")
      if let homePath = value.homePath {
        self.homePath = homePath
      }
      if let listsPath = value.listsPath {
        self.listsPath = listsPath
      }
      if let moviesPath = value.moviesPath {
        self.moviesPath = moviesPath
      }
      if let tvShowsPath = value.tvShowsPath {
        self.tvShowsPath = tvShowsPath
      }
      if let searchPath = value.searchPath {
        self.searchPath = searchPath
      }
      if let selectedTab = value.selectedTab {
        self.selectedTab = selectedTab
      }
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private struct RestorationData: Codable {
    var homePath: [Destination]?
    var listsPath: [Destination]?
    var moviesPath: [Destination]?
    var tvShowsPath: [Destination]?
    var searchPath: [Destination]?
    var selectedTab: Tab?
  }
}
