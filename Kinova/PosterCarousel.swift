//
//  PosterCarousel.swift
//  Kinova
//
//  Created by Igor Camilo on 22.07.25.
//

import SwiftUI

struct PosterCarousel: View {
    let posters: [PosterModel]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(posters) { poster in
                    AsyncImage(url: poster.posterURL) { image in
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
    }
}

#Preview {
    PosterCarousel(posters: [])
}
