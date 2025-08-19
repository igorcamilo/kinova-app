//
//  TVShow+CarouselItem.swift
//  Kinova
//
//  Created by Igor Camilo on 09.08.25.
//

import TMDB

extension TVShow: ImageCarouselItem {
  var destination: Destination {
    .tvShow(id: id, title: name)
  }

  var image: CarouselImage {
    return .poster(posterPath)
  }

  var title: String { name }

  static func placeholders(count: Int) -> [TVShow] {
    (0..<count).map {
      TVShow(
        adult: false,
        backdropPath: nil,
        genreIDs: [],
        id: ID(rawValue: $0),
        originCountry: [],
        originalLanguage: "",
        originalName: "",
        overview: "",
        popularity: 0,
        posterPath: nil,
        firstAirDate: "",
        name: "TV Show \($0)",
        voteAverage: 0,
        voteCount: 0
      )
    }
  }
}
