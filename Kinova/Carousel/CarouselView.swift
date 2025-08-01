//
//  CarouselView.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import SwiftUI

struct CarouselView: View {
  let title: LocalizedStringKey
  let viewModel: CarouselViewModel
  let action: (CarouselViewModel.Item.ID) -> Void

  static let posterSize = CGSize(width: 180, height: 270)

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.title)
        .padding(.horizontal)
      switch viewModel.state {
      case .loaded(let items):
        loadedView(items: items)
      case .placeholder:
        placeholderView()
      }
    }
  }

  private func loadedView(items: [CarouselViewModel.Item]) -> some View {
    ScrollView(.horizontal) {
      LazyHStack(alignment: .top) {
        ForEach(items) { item in
          Button {
            action(item.id)
          } label: {
            loadedItemView(item)
          }
          .buttonStyle(.plain)
        }
      }
      .padding(.horizontal)
    }
    .scrollIndicators(.never)
  }

  private func loadedItemView(_ item: CarouselViewModel.Item) -> some View {
    VStack {
      AsyncImage(url: item.imageURL) { image in
        image.resizable()
      } placeholder: {
        Color.secondary
      }
      .imageConfig()
      Text(item.title)
        .textConfig()
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
        .imageConfig()
      Text(verbatim: "Lorem ipsum")
        .textConfig()
    }
  }
}

extension View {
  fileprivate func imageConfig() -> some View {
    self.frame(
      width: CarouselView.posterSize.width,
      height: CarouselView.posterSize.height
    )
  }

  fileprivate func textConfig() -> some View {
    self.multilineTextAlignment(.center)
      .font(.body)
      .lineLimit(1)
      .frame(
        width: CarouselView.posterSize.width
      )
  }
}

#Preview {
  CarouselView(
    title: "Lorem Ipsum",
    viewModel: CarouselViewModel(
      list: .movies(.nowPlaying)
    ),
    action: { _ in }
  )
}
