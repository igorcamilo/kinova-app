//
//  Genre+CarouselItem.swift
//  Kinova
//
//  Created by Igor Camilo on 10.08.25.
//

import TMDB

extension Genre: TextCarouselItem {
  var destination: Destination {
    .genre(id: id, title: name)
  }

  var title: String { name }

  static func placeholders(count: Int) -> [Genre] {
    (0..<count).map {
      var genre = Genre()
      genre.id = ID(rawValue: $0)
      genre.name = "Genre \($0)"
      return genre
    }
  }
}
