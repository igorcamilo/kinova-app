//
//  MovieDetailViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import Observation
import TMDB

@MainActor
@Observable
final class MovieDetailViewModel {
  let client: Client
  let id: Movie.ID

  var similar: [CarouselItem] = []

  var movieDetail: MovieDetailViewModel?

  init(client: Client = .shared, id: Movie.ID) {
    self.client = client
    self.id = id
  }

  func load() async {
  }
}
