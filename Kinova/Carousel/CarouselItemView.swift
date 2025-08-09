//
//  CarouselItemView.swift
//  Kinova
//
//  Created by Igor Camilo on 09.08.25.
//

import SwiftUI
import TMDB
import os

struct CarouselItemView: View {
  let path: CarouselImage?

  @Environment(Configuration.self) private var configuration
  @Environment(\.carouselItemHeight) private var carouselItemHeight
  @Environment(\.displayScale) private var displayScale

  private var images: Images? {
    configuration.value?.images
  }

  private var width: CGFloat {
    switch path {
    case .poster, nil:
      carouselItemHeight * 2 / 3
    }
  }

  private var url: URL? {
    guard let images else {
      return nil
    }
    let scaledWidth = width * displayScale
    switch path {
    case .poster(let posterPath):
      return images.url(width: scaledWidth, path: posterPath)
    case nil:
      return nil
    }
  }

  var body: some View {
    AsyncImage(url: url) { image in
      image.resizable().aspectRatio(contentMode: .fill)
    } placeholder: {
      Color.secondary
    }
    .frame(width: width, height: carouselItemHeight)
    .clipped()
    .onAppear { Task { await configuration.loadIfNeeded() } }
  }
}
