//
//  CarouselView.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import SwiftUI

struct CarouselView<T: CarouselItem>: View {
  let title: LocalizedStringKey
  let items: [T]

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

  private func loadedItemView(_ item: T) -> some View {
    CarouselItemView(path: item.image)
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
    CarouselItemView(path: nil)
  }
}

#Preview {
//  CarouselView(
//    title: "Lorem Ipsum",
//    items: [],
//  )
}
