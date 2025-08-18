//
//  TextCarousel.swift
//  Kinova
//
//  Created by Igor Camilo on 10.08.25.
//

import SwiftUI
import TMDB

struct TextCarousel<Item: TextCarouselItem>: View {
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
    .buttonStyle(.bordered)
    .redacted(reason: items == nil ? [.placeholder] : [])
    .disabled(items?.isEmpty != false)
    .sectionTitle(title)
  }

  private var contents: some View {
    ForEach(renderedItems) { item in
      NavigationLink(value: item.destination) {
        Text(item.title)
          .font(.body)
      }
    }
    .hidden(if: items?.isEmpty == true)
  }
}

protocol TextCarouselItem: Codable, Hashable, Identifiable, Sendable {
  var destination: Destination { get }
  var title: String { get }

  static func placeholders(count: Int) -> [Self]
}

#Preview {
  NavigationStack {
    TextCarousel<Genre>(title: "Placeholder", items: nil)
    TextCarousel<Genre>(title: "Empty", items: [])
    TextCarousel<Genre>(title: "Single", items: Genre.placeholders(count: 1))
    TextCarousel<Genre>(title: "Multiple", items: Genre.placeholders(count: 10))
  }
}
