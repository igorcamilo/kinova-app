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

@MainActor @Observable final class RootViewModel {
  let client: TMDBClient

  var moviesPath: [Destination] = []
  var tvShowsPath: [Destination] = []
  var selectedTab = Tab.movies

  init(client: TMDBClient = .shared) {
    self.client = client
  }

  enum Tab: String, Codable, Hashable, Sendable {
    case movies
    case tvShows
  }

  func restorationData() -> Data? {
    let value = RestorationData(
      moviesPath: moviesPath,
      tvShowsPath: tvShowsPath,
      selectedTab: selectedTab
    )
    do {
      #if DEBUG
        encoder.outputFormatting = .prettyPrinted
      #endif
      let data = try encoder.encode(value)
      #if DEBUG
        let string = String(data: data, encoding: .utf8) ?? "nil"
        logger.debug("\(#function) returned: \(string)")
      #endif
      return data
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
      if let moviesPath = value.moviesPath {
        self.moviesPath = moviesPath
      }
      if let tvShowsPath = value.tvShowsPath {
        self.tvShowsPath = tvShowsPath
      }
      if let selectedTab = value.selectedTab {
        self.selectedTab = selectedTab
      }
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }

  private struct RestorationData: Codable {
    var moviesPath: [Destination]?
    var tvShowsPath: [Destination]?
    var selectedTab: Tab?
  }
}
