//
//  Destination.swift
//  Kinova
//
//  Created by Igor Camilo on 02.08.25.
//

import TMDB

enum Destination: Codable, Hashable, Sendable {
  case movie(id: Movie.ID, title: String)
  case tvShow(id: TVShow.ID, title: String)
}
