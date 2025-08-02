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

  @Environment(\.carouselItemSize) private var itemSize

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.title)
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
    VStack {
      AsyncImage(url: item.imageURL) { image in
        image.resizable()
      } placeholder: {
        Color.secondary
      }
      .imageConfig(size: itemSize)
      Text(item.title)
        .textConfig(size: itemSize)
    }
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
    VStack {
      Color.secondary
        .imageConfig(size: itemSize)
      Text(verbatim: "Lorem ipsum")
        .textConfig(size: itemSize)
    }
  }
}

extension View {
  fileprivate func imageConfig(size: CGSize) -> some View {
    self.frame(width: size.width, height: size.height)
  }

  fileprivate func textConfig(size: CGSize) -> some View {
    self.multilineTextAlignment(.center)
      .font(.body)
      .lineLimit(1)
      .frame(width: size.width)
  }
}

#Preview {
  CarouselView(
    title: "Lorem Ipsum",
    items: [],
  )
}
