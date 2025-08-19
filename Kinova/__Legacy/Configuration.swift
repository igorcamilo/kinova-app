//
//  Configuration.swift
//  Kinova
//
//  Created by Igor Camilo on 09.08.25.
//

import Observation
import TMDB
import os

private let logger = Logger(
  subsystem: Constants.subsystem,
  category: #fileID
)

@Observable class Configuration {
  let client: TMDBClient

  private(set) var isLoading = false
  private(set) var value: TMDB.Configuration?

  init(client: TMDBClient = .shared) {
    self.client = client
  }

  func loadIfNeeded() async {
    if isLoading {
      return
    }
    if value != nil {
      return
    }
    isLoading = true
    defer { isLoading = false }
    do {
      value = try await client.configuration()
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }
}
