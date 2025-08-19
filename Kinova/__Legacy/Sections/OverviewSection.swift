//
//  OverviewSection.swift
//  Kinova
//
//  Created by Igor Camilo on 11.08.25.
//

import SwiftUI
import TMDB

private let placeholder = """
  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
  """

struct OverviewSection: View {
  let value: String?

  private var renderedValue: String {
    guard let value else {
      return placeholder
    }
    if value.isEmpty {
      return "A"
    } else {
      return value
    }
  }

  var body: some View {
    Text(renderedValue)
      .font(.body)
      .hidden(if: value?.isEmpty == true)
      .redacted(reason: value == nil ? [.placeholder] : [])
      .disabled(value?.isEmpty != false)
      .horizontalMargin()
      .sectionTitle("Overview")
  }
}

#Preview {
  VStack(alignment: .leading, spacing: 16) {
    OverviewSection(value: nil)
    OverviewSection(value: "")
    OverviewSection(value: "A")
    OverviewSection(value: placeholder)
  }
}
