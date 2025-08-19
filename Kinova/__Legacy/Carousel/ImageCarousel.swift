//
//  ImageCarousel.swift
//  Kinova
//
//  Created by Igor Camilo on 10.08.25.
//

import SwiftUI
import TMDB

struct ImageCarousel<Item: ImageCarouselItem>: View {
  let title: LocalizedStringKey
  let items: [Item]?

  private var renderedItems: [Item] {
    guard let items else {
      return Item.placeholders(count: 10)
    }
    if items.isEmpty {
      return Item.placeholders(count: 1)
    } else {
      return items
    }
  }

  var body: some View {
    ScrollView(.horizontal) {
      HStack(alignment: .firstTextBaseline) {
        contents
      }
      .horizontalMargin()
    }
    .scrollIndicators(.never)
    .buttonStyle(.plain)
    .redacted(reason: items == nil ? [.placeholder] : [])
    .disabled(items?.isEmpty != false)
    .sectionTitle(title)
  }

  private var contents: some View {
    ForEach(renderedItems) { item in
      NavigationLink(value: item.destination) {
        ItemView(image: item.image)
      }
    }
    .hidden(if: items?.isEmpty == true)
  }

  private struct ItemView: View {
    let image: CarouselImage

    @Environment(Configuration.self) private var configuration
    @Environment(\.displayScale) private var displayScale
    @ScaledMetric(relativeTo: .subheadline) private var height: CGFloat = 240

    private var images: Images? {
      configuration.value?.images
    }

    private var width: CGFloat {
      switch image {
      case .poster:
        height * 2 / 3
      }
    }

    private var url: URL? {
      guard let images else {
        return nil
      }
      let scaledWidth = width * displayScale
      switch image {
      case .poster(let posterPath):
        guard let posterPath else { return nil }
        return images.url(width: scaledWidth, path: posterPath)
      }
    }

    var body: some View {
      AsyncImage(url: url) { image in
        image.resizable().aspectRatio(contentMode: .fill)
      } placeholder: {
        Color.secondary
      }
      .frame(width: width, height: height)
      .clipped()
      .onAppear {
        Task {
          await configuration.loadIfNeeded()
        }
      }
    }
  }
}

enum CarouselImage: Codable, Hashable, Sendable {
  case poster(PosterPath?)
}

protocol ImageCarouselItem: TextCarouselItem {
  var image: CarouselImage { get }
}

#Preview {
  NavigationStack {
    TextCarousel<Movie>(title: "Placeholder", items: nil)
    TextCarousel<TVShow>(title: "Empty", items: [])
    TextCarousel<Movie>(title: "Single", items: Movie.placeholders(count: 1))
    TextCarousel<TVShow>(title: "Multiple", items: TVShow.placeholders(count: 10))
  }
}
