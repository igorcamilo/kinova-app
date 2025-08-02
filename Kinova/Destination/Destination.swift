//
//  Destination.swift
//  Kinova
//
//  Created by Igor Camilo on 02.08.25.
//

import TMDB

enum Destination: Codable, CustomDebugStringConvertible, Hashable, Sendable {
  case movie(Movie.ID)
  case tvShow(TVShow.ID)

  var debugDescription: String {
    switch self {
    case .movie(let id):
      return "Destination.movie(\(id.rawValue))"
    case .tvShow(let id):
      return "Destination.tvShow(\(id.rawValue))"
    }
  }
}
