//
//  CarouselItem.swift
//  Kinova
//
//  Created by Igor Camilo on 02.08.25.
//

import Foundation
import TMDB

struct CarouselItem: Codable, Hashable, Identifiable, Sendable {
  var id: ID
  var imageURL: URL?
  var title: String

  var destination: Destination {
    switch id {
    case .movie(let id):
      return .movie(id)
    case .tvShow(let id):
      return .tvShow(id)
    }
  }

  enum ID: Codable, Hashable, Sendable {
    case movie(Movie.ID)
    case tvShow(TVShow.ID)
  }
}
