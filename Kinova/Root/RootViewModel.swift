//
//  RootViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import Observation
import TMDB

@MainActor @Observable final class RootViewModel {
  let client: TMDBClient

  var moviesPath: [Destination] = []
  var tvShowsPath: [Destination] = []
  var selectedTab = RootTab.movies

  init(client: TMDBClient = .shared) {
    self.client = client
  }
}
