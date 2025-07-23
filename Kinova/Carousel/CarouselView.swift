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

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title)
                .padding(.horizontal)
            switch viewModel.state {
            case let .loaded(items):
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(items) { item in
                            AsyncImage(url: item.imageURL) { image in
                                image.resizable()
                            } placeholder: {
                                Color.secondary
                            }
                            .frame(width: 180, height: 270)
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.never)
            case .placeholder:
                HStack {
                    ForEach(1...10, id: \.self) { _ in
                        Color.secondary.frame(width: 180, height: 270)
                    }
                }
            }
        }
    }
}

#Preview {
    CarouselView(
        title: "Title",
        viewModel: CarouselViewModel(
            list: .movies(.nowPlaying)
        )
    )
}
