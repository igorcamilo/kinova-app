//
//  RootViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import Observation
import TMDB
import os

private let logger = Logger(subsystem: "com.igorcamilo.kinova", category: "RootViewModel")

@MainActor
@Observable
final class RootViewModel {
  let client: TMDBClient

  var moviesPath: [Destination] = [] {
    didSet {
      let newValue = moviesPath
      logger.debug("Updated movies path \(newValue)")
    }
  }
  var tvShowsPath: [Destination] = [] {
    didSet {
      let newValue = tvShowsPath
      logger.debug("Updated TV shows path \(newValue)")
    }
  }

  var selectedTab = RootTab.movies {
    didSet {
      let newValue = selectedTab.rawValue
      logger.debug("Updated selected tab \(newValue)")
    }
  }

  init(client: TMDBClient = .shared) {
    logger.debug("Initializing RootViewModel")
    self.client = client
  }

  deinit {
    logger.debug("Deinitializing RootViewModel")
  }
}
