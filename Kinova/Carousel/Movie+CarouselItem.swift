//
//  Movie+CarouselItem.swift
//  Kinova
//
//  Created by Igor Camilo on 09.08.25.
//

import TMDB

extension Movie: CarouselItem {
  var caption: String? {
    title
  }

  var destination: Destination {
    .movie(id)
  }

  var image: CarouselImage? {
    guard let posterPath else {
      return nil
    }
    return .poster(posterPath)
  }
}
