//
//  MoviesViewModel.swift
//  Kinova
//
//  Created by Igor Camilo on 22.07.25.
//

import Observation
import TMDB

@MainActor
@Observable
final class MoviesViewModel {
    let client: Client

    var nowPlaying = [PosterModel]()
    var popular = [PosterModel]()
    var topRated = [PosterModel]()
    var upcoming = [PosterModel]()

    init(client: Client = .shared) {
        self.client = client
    }

    func getNowPlaying() async {
        do {
            nowPlaying = try await client.posters(movieList: .nowPlaying)
        } catch {
            print("nowPlaying", error)
        }
    }

    func getPopular() async {
        do {
            popular = try await client.posters(movieList: .popular)
        } catch {
            print("popular", error)
        }
    }

    func getTopRated() async {
        do {
            topRated = try await client.posters(movieList: .topRated)
        } catch {
            print("topRated", error)
        }
    }

    func getUpcoming() async {
        do {
            upcoming = try await client.posters(movieList: .upcoming)
        } catch {
            print("upcoming", error)
        }
    }
}
