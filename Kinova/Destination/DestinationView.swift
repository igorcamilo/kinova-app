//
//  DestinationView.swift
//  Kinova
//
//  Created by Igor Camilo on 02.08.25.
//

import SwiftUI
import TMDB

struct DestinationView: View {
  let destination: Destination

  var body: some View {
    Group {
      switch destination {
      case .movie(let id, let title):
        MovieDetailsView(id: id, title: title)
      case .tvShow(let id, let title):
        TVShowDetailsView(id: id, title: title)
      }
    }
    #if os(macOS)
      .frame(minWidth: 375)
    #endif
  }
}

#Preview("Movie") {
  NavigationStack {
    let id = Movie.ID(rawValue: 569094)
    let title = "Spider-Man: Across the Spider-Verse"
    DestinationView(destination: .movie(id: id, title: title))
  }
}

#Preview("TV Show") {
  NavigationStack {
    let id = TVShow.ID(rawValue: 94605)
    let title = "Arcane"
    DestinationView(destination: .tvShow(id: id, title: title))
  }
}
