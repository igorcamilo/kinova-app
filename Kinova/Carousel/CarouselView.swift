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

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title)
                .padding(.horizontal)
            switch viewModel.state {
            case let .loaded(items):
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
            .imageFrame()
            Text(item.title)
                .font(.body)
                .textFrame()
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
                .imageFrame()
            Text("Lorem ipsum dolor sit amet consectetur adipisicing elit")
                .font(.body)
                .textFrame()
        }
    }
}

private extension View {
    func imageFrame() -> some View {
        self.frame(width: 180, height: 270)
    }

    func textFrame() -> some View {
        self.lineLimit(2, reservesSpace: true).frame(width: 180)
    }
}

#Preview {
    CarouselView(
        title: "Title",
        viewModel: CarouselViewModel(
            list: .movies(.nowPlaying)
        ),
        action: { _ in }
    )
}
