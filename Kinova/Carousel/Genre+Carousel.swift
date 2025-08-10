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
      Genre(id: ID(rawValue: $0), name: "Genre \($0)")
    }
  }
}
