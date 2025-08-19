//
//  BackdropContainer.swift
//  Kinova
//
//  Created by Igor Camilo on 09.08.25.
//

import SwiftUI
import TMDB

struct BackdropContainer<Contents: View>: View {
  let path: BackdropPath?
  let contents: Contents

  @Environment(ContainerGeometry.self) private var containerGeometry

  init(
    path: BackdropPath?,
    contents: () -> Contents
  ) {
    self.path = path
    self.contents = contents()
  }

  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: 0) {
        BackdropView(path: path)
          .aspectRatio(16 / 9, contentMode: .fill)
          .frame(maxHeight: containerGeometry.size.height / 2)
          .clipped()
          .backgroundEffect()
        contents
      }
    }
  }
}

extension View {
  fileprivate func backgroundEffect() -> some View {
    if #available(iOS 26.0, macOS 26.0, tvOS 26.0, visionOS 26.0, watchOS 26.0, *) {
      return self.backgroundExtensionEffect()
    } else {
      return self
    }
  }
}
