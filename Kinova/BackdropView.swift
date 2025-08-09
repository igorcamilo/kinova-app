//
//  BackdropView.swift
//  Kinova
//
//  Created by Igor Camilo on 09.08.25.
//

import SwiftUI
import TMDB
import os

struct BackdropView: View {
  let path: BackdropPath?

  @Environment(Configuration.self) private var configuration

  @Environment(Dimensions.self) private var dimensions

  @Environment(\.displayScale) private var displayScale

  private var images: Images? {
    configuration.value?.images
  }

  private var url: URL? {
    guard let path else {
      return nil
    }
    guard let images else {
      return nil
    }
    let size = images.size(
      width: dimensions.size.width * displayScale,
      from: \.backdropSizes
    )
    guard let size else {
      return nil
    }
    guard let url = images.url(size: size, path: path) else {
      return nil
    }
    return url
  }

  var body: some View {
    AsyncImage(url: url) { image in
      image.resizable().aspectRatio(contentMode: .fill)
    } placeholder: {
      Color.secondary
    }
    .onAppear { Task { await configuration.loadIfNeeded() } }
  }
}
