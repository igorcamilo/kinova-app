//
//  PosterView.swift
//  Kinova
//
//  Created by Igor Camilo on 04.08.25.
//

import SwiftUI

struct PosterView: View {
  let imageURL: URL?
  let caption: String?

  @Environment(\.posterSize) private var size

  var body: some View {
    VStack {
      AsyncImage(url: imageURL) { image in
        image.resizable()
      } placeholder: {
        Color.secondary
      }
      .frame(
        width: size.width,
        height: size.height
      )
      if let caption {
        Text(caption)
          .multilineTextAlignment(.center)
          .font(.body)
          .lineLimit(1)
          .frame(width: size.width)
      }
    }
  }
}

#Preview {
  PosterView(
    imageURL: nil,
    caption: "Lorem ipsum dolor sit amet"
  )
}
