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

private let logger = Logger(subsystem: "com.igorcamilo.kinova", category: "TVShowDetailsViewModel")

@MainActor
@Observable
final class TVShowDetailsViewModel {
  let client: TMDBClient

  var posterURL: URL?
  var title: String?
  var similar: [CarouselItem] = []

  init(client: TMDBClient = .shared) {
    logger.debug("Initializing TVShowDetailsViewModel")
    self.client = client
  }

  deinit {
    logger.debug("Deinitializing TVShowDetailsViewModel")
  }

  func load(id: TVShow.ID, bigWidth: CGFloat, smallWidth: CGFloat) async {
    logger.debug("Loading tv show detail id: \(id.rawValue)")
    do {
      async let tvShowDetails = client.tvShowDetails(id: id)
      let images = try await client.configuration().images
      let bigSize = images.size(width: bigWidth, from: \.posterSizes)
      let smallSize = images.size(width: smallWidth, from: \.posterSizes)
      if let bigSize {
        posterURL = images.url(size: bigSize, path: try await tvShowDetails.posterPath)
      }
      title = try await tvShowDetails.name
      if let similarTVShows = try await tvShowDetails.similar {
        similar = similarTVShows.results.map { tvShow in
          let url = smallSize.flatMap { images.url(size: $0, path: tvShow.posterPath) }
          return CarouselItem(id: .tvShow(tvShow.id), imageURL: url, title: tvShow.name)
        }
      }
    } catch URLError.cancelled {
      logger.info("TV show detail loading cancelled")
    } catch {
      logger.warning("Failed to load tv show detail: \(error)")
    }
  }
}
