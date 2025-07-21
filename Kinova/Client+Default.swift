//
//  Client+Default.swift
//  Kinova
//
//  Created by Igor Camilo on 20.07.25.
//

import TMDB

extension Client {
    static let `default` = Client(
        accessToken: KinovaSecrets.tmdbAccessToken
    )
}
