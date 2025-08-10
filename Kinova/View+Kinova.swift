//
//  View+Kinova.swift
//  Kinova
//
//  Created by Igor Camilo on 10.08.25.
//

import SwiftUI

extension View {
  @ViewBuilder func hidden(if condition: Bool) -> some View {
    if condition {
      self.hidden()
    } else {
      self
    }
  }

  func horizontalMargin() -> some View {
    self.padding(.horizontal)
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
