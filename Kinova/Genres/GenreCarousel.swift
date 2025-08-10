//
//  GenreCarousel.swift
//  Kinova
//
//  Created by Igor Camilo on 10.08.25.
//

import SwiftUI
import TMDB

fileprivate let placeholder = (1...10).map {
  Genre(id: Genre.ID(rawValue: $0), name: "Genre \($0)")
}

struct GenreCarousel: View {
  let title: LocalizedStringKey
  let genres: [Genre]?

  private var rederedGenres: [Genre] {
    guard let genres, !genres.isEmpty else {
      return placeholder
    }
    return genres
  }

  var body: some View {
    ScrollView(.horizontal) {
      HStack(alignment: .firstTextBaseline) {
        ForEach(rederedGenres) { genre in
          NavigationLink(value: genre.id) {
            Text(genre.name)
              .font(.body)
          }
        }
        .hidden(if: genres == [])
      }
      .horizontalMargin()
    }
    .scrollIndicators(.never)
    .buttonStyle(.bordered)
    .redacted(reason: genres == nil ? [.placeholder] : [])
    .disabled(genres?.isEmpty != false)
    .sectionTitle(title)
  }
}

#Preview {
  NavigationStack {
    GenreCarousel(title: "Placeholder", genres: nil)
    GenreCarousel(title: "Empty", genres: [])
    GenreCarousel(title: "Single", genres: [Genre(id: 1, name: "Genre 1")])
    GenreCarousel(title: "Multiple", genres: placeholder)
  }
}
