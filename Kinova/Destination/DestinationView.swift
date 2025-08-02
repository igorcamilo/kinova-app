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
    switch destination {
    case .movie(let id):
      MovieDetailView(id: id)
    case .tvShow(let id):
      TVShowDetailView(id: id)
    }
  }
}

#Preview("Movie") {
  NavigationStack {
    let id = Movie.ID(rawValue: 569094)
    DestinationView(destination: .movie(id))
  }
}

#Preview("TV Show") {
  NavigationStack {
    let id = TVShow.ID(rawValue: 94605)
    DestinationView(destination: .tvShow(id))
  }
}
