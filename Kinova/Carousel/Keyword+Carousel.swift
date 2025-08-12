//
//  Keyword+Carousel.swift
//  Kinova
//
//  Created by Igor Camilo on 11.08.25.
//

import TMDB

extension Keyword: TextCarouselItem {
  var destination: Destination {
    .keyword(id: id, title: name)
  }

  var title: String { name }

  static func placeholders(count: Int) -> [Keyword] {
    (0..<count).map {
      var keyword = Keyword()
      keyword.id = ID(rawValue: $0)
      keyword.name = "Keyword \($0)"
      return keyword
    }
  }
}
