//
//  View+Kinova.swift
//  Kinova
//
//  Created by Igor Camilo on 10.08.25.
//

import SwiftUI

extension View {
  func containerGeometry() -> some View {
    modifier(ContainerGeometryModifier())
  }

  @ViewBuilder func hidden(if condition: Bool) -> some View {
    if condition {
      hidden()
    } else {
      self
    }
  }

  func horizontalMargin() -> some View {
    padding(.horizontal)
  }

  func sectionTitle(_ title: LocalizedStringKey) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.headline)
        .horizontalMargin()
      self
    }
  }
}

private struct ContainerGeometryModifier: ViewModifier {
  @State private var containerGeometry = ContainerGeometry()

  func body(content: Content) -> some View {
    content
      .environment(containerGeometry)
      .onGeometryChange(for: Values.self) {
        Values(safeAreaInsets: $0.safeAreaInsets, size: $0.size)
      } action: {
        containerGeometry.safeAreaInsets = $0.safeAreaInsets
        containerGeometry.size = $0.size
      }
  }

  private struct Values: nonisolated Equatable {
    var safeAreaInsets: EdgeInsets
    var size: CGSize
  }
}

private struct HorizontalMarginModifier: ViewModifier {
  @Environment(ContainerGeometry.self) private var containerGeometry
  @ScaledMetric(relativeTo: .body) private var readableWidth: CGFloat = 600

  private var padding: CGFloat {
    (containerGeometry.size.width - readableWidth) / 2
  }

  func body(content: Content) -> some View {
    content.padding(.horizontal, max(padding, 16))
  }
}
