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

  @State private var dimensions = Dimensions()
  @State private var scrollOffset = CGFloat.zero

  init(
    path: BackdropPath?,
    contents: () -> Contents
  ) {
    self.path = path
    self.contents = contents()
  }

  var body: some View {
    ScrollView(.vertical) { scrollContents }
      .background(alignment: .top) { background }
      .onScrollGeometryChange(for: CGFloat.self) {
        $0.contentInsets.top + $0.contentOffset.y
      } action: {
        scrollOffset = $1
      }
      .onGeometryChange(for: CGSize.self, of: \.size) {
        dimensions.size = $1
      }
      .environment(dimensions)
  }

  private var backdropHeight: CGFloat {
    min(dimensions.size.height / 2, 400)
  }

  private var background: some View {
    BackdropView(path: path)
      .frame(height: backdropHeight)
      .clipped()
      .offset(y: min(-scrollOffset, 0))
      .backgroundEffect()
  }

  private var scrollContents: some View {
    LazyVStack(spacing: 0) {
      Spacer().frame(height: backdropHeight)
      contents
    }
  }
}

extension View {
  fileprivate func backgroundEffect() -> some View {
    if #available(iOS 26.0, macOS 26.0, visionOS 26.0, *) {
      return self.backgroundExtensionEffect()
    } else {
      return self
    }
  }
}
