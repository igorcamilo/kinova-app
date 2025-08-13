//
//  MovieDetailsReducer.swift
//  KinovaCore
//
//  Created by Igor Camilo on 13.08.25.
//

import ComposableArchitecture
import Dependencies
import TMDB

@Reducer
struct MovieDetailsReducer {
  @ObservableState
  struct State {
    var aaa = false
  }

  enum Action: ViewAction {
    case view(View)

    enum View {
      case viewAppeared
    }
  }

  @Dependency(\.movieClient) private var movieClient

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .view(.viewAppeared):
        return viewAppeared(state: &state)
      }
    }
  }

  private func viewAppeared(
    state: inout State
  ) -> Effect<Action> {
    return .none
  }
}
