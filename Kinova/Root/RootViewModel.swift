//
//  RootViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import Observation
import TMDB

@MainActor
@Observable
final class RootViewModel {
  let client: Client

  var moviesPath: [Destination] = []
  var tvShowsPath: [Destination] = []

  var selectedTab = RootTab.movies

  init(client: Client = .shared) {
    self.client = client
  }
}
