//
//  Client+Shared.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import TMDB

extension Client {
    static let shared = Client(
        accessToken: KinovaSecrets.tmdbAccessToken
    )
}
