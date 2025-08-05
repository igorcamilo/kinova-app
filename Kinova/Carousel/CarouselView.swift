//
//  CarouselView.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import SwiftUI

struct CarouselView: View {
  let title: LocalizedStringKey
  let items: [CarouselItem]

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.headline)
        .padding(.horizontal)
      if items.isEmpty {
        placeholderView()
      } else {
        loadedView()
      }
    }
  }

  private func loadedView() -> some View {
    ScrollView(.horizontal) {
      LazyHStack(alignment: .top) {
        ForEach(items) { item in
          NavigationLink(value: item.destination) {
            loadedItemView(item)
          }
          .buttonStyle(.plain)
        }
      }
      .padding(.horizontal)
    }
    .scrollIndicators(.never)
  }

  private func loadedItemView(_ item: CarouselItem) -> some View {
    PosterView(
      imageURL: item.imageURL,
      caption: item.title
    )
  }

  private func placeholderView() -> some View {
    ScrollView(.horizontal) {
      LazyHStack(alignment: .top) {
        ForEach(1...10, id: \.self) { _ in
          placeholderItemView()
        }
      }
      .padding(.horizontal)
    }
    .scrollDisabled(true)
    .redacted(reason: .placeholder)
  }

  private func placeholderItemView() -> some View {
    PosterView(
      imageURL: nil,
      caption: "Lorem Ipsum"
    )
  }
}

#Preview {
  CarouselView(
    title: "Lorem Ipsum",
    items: [],
  )
}
