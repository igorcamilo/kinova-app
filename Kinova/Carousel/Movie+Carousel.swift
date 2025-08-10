//
//  Movie+CarouselItem.swift
//  Kinova
//
//  Created by Igor Camilo on 09.08.25.
//

import TMDB

extension Movie: ImageCarouselItem {
  var destination: Destination {
    .movie(id: id, title: title)
  }

  var image: CarouselImage {
    return .poster(posterPath)
  }

  static func placeholders(count: Int) -> [Movie] {
    (1...count).map {
      Movie(
        adult: false,
        backdropPath: nil,
        genreIDs: nil,
        id: ID(rawValue: $0),
        originalLanguage: "",
        originalTitle: "",
        overview: "",
        popularity: nil,
        posterPath: nil,
        releaseDate: nil,
        title: "Movie \($0)",
        video: nil,
        voteAverage: nil,
        voteCount: nil
      )
    }
  }
}
