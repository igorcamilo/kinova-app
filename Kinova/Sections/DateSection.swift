//
//  DateSection.swift
//  Kinova
//
//  Created by Igor Camilo on 11.08.25.
//

import Foundation
import SwiftUI
import TMDB

private let placeholder = """
  Lorem ipsum dolor sit amet.
  """

private let converter = DateSection.Converter()

struct DateSection: View {
  let title: LocalizedStringKey
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
    converter.convert(string: renderedValue)
      .font(.body)
      .hidden(if: value?.isEmpty == true)
      .redacted(reason: value == nil ? [.placeholder] : [])
      .disabled(value?.isEmpty != false)
      .horizontalMargin()
      .sectionTitle(title)
  }

  struct Converter {
    private let formatter = DateFormatter()

    init() {
      formatter.dateFormat = "yyyy-MM-dd"
      formatter.locale = Locale(identifier: "en_US_POSIX")
    }

    func convert(string: String) -> Text {
      guard let date = formatter.date(from: string) else {
        return Text(string)
      }
      let absolute = date.formatted(date: .abbreviated, time: .omitted)
      let relative = date.formatted(
        .relative(presentation: .numeric, unitsStyle: .abbreviated)
      )
      return Text("\(absolute) (\(relative))")
    }
  }
}

#Preview {
  VStack(alignment: .leading, spacing: 16) {
    DateSection(title: "Placeholder", value: nil)
    DateSection(title: "Empty", value: "")
    DateSection(title: "Invalid", value: "01-01-2000")
    DateSection(title: "Past", value: "2000-01-01")
    DateSection(title: "Future", value: "2050-01-01")
  }
}
