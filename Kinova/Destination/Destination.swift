//
//  Destination.swift
//  Kinova
//
//  Created by Igor Camilo on 02.08.25.
//

import TMDB

enum Destination: Codable, Hashable, Sendable {
  case genre(id: Genre.ID, title: String)
  case keyword(id: Keyword.ID, title: String)
  case movie(id: Movie.ID, title: String)
  case tvShow(id: TVShow.ID, title: String)
}
