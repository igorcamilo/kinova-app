//
//  PosterModel.swift
//  Kinova
//
//  Created by Igor Camilo on 22.07.25.
//

import Foundation
import TMDB

struct PosterModel: Codable, Hashable, Identifiable, Sendable {
    var id: ID
    var posterURL: URL
    var title: String

    enum ID: Codable, Hashable, Sendable {
        case movie(Movie.ID)
        case tvShow(TVShow.ID)
    }
}
