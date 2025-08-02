//
//  TVShowDetailViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 27.07.25.
//

import Foundation
import Observation
import TMDB
import os

private let logger = Logger(subsystem: "com.igorcamilo.kinova", category: "TVShowDetailViewModel")

@MainActor
@Observable
final class TVShowDetailViewModel {
  let client: Client

  var similar: [CarouselItem] = []

  var tvShowDetail: TVShowDetailViewModel?

  init(client: Client = .shared) {
    logger.debug("Initializing TVShowDetailViewModel")
    self.client = client
  }

  deinit {
    logger.debug("Deinitializing TVShowDetailViewModel")
  }

  func load(id: TVShow.ID, width: CGFloat) async {
    logger.debug("Loading tv show detail id: \(id.rawValue)")
    do {
      async let similarTVShows = client.tvShows(list: .similar(id))
      let images = try await client.configuration().images
      let size = images.size(width: width, from: \.posterSizes)
      similar = try await similarTVShows.results.map { tvShow in
        let url = size.flatMap { images.url(size: $0, path: tvShow.posterPath) }
        return CarouselItem(id: .tvShow(tvShow.id), imageURL: url, title: tvShow.name)
      }
    } catch URLError.cancelled {
      logger.info("TV show detail loading cancelled")
    } catch {
      logger.warning("Failed to load tv show detail: \(error)")
    }
  }
}
