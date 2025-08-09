//
//  TVShow+CarouselItem.swift
//  Kinova
//
//  Created by Igor Camilo on 09.08.25.
//

import TMDB

extension TVShow: CarouselItem {
  var caption: String? {
    name
  }
  
  var destination: Destination {
    .tvShow(id)
  }
  
  var image: CarouselImage? {
    guard let posterPath else {
      return nil
    }
    return .poster(posterPath)
  }
}
