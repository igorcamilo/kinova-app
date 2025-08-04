//
//  Client+Kinova.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import TMDB

extension TMDBClient {
  static let shared = TMDBClient(
    accessToken: KinovaSecrets.tmdbAccessToken
  )
}
