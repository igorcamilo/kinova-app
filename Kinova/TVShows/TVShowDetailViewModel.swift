//
//  TVShowDetailViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 27.07.25.
//

import Observation
import TMDB

@MainActor
@Observable
final class TVShowDetailViewModel {
  let client: Client
  let id: TVShow.ID

  let similar: [CarouselItem] = []

  var tvShowDetail: TVShowDetailViewModel?

  init(client: Client = .shared, id: TVShow.ID) {
    self.client = client
    self.id = id
  }

  func load() async {
  }
}
