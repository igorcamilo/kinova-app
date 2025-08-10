//
//  TVShowDetailsViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 27.07.25.
//

import Foundation
import Observation
import TMDB
import os

private let logger = Logger(
  subsystem: Constants.subsystem,
  category: #fileID
)

@MainActor @Observable final class TVShowDetailsViewModel {
  let client: TMDBClient

  private(set) var isLoading = false
  private(set) var value: TVShowDetails?

  init(client: TMDBClient = .shared) {
    self.client = client
  }

  func load(id: TVShow.ID) async {
    if isLoading {
      return
    }
    isLoading = true
    defer { isLoading = false }
    do {
      value = try await client.tvShowDetails(id: id)
    } catch {
      logger.error("\(#function) error: \(error)")
    }
  }
}
