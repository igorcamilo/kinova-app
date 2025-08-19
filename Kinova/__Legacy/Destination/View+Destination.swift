//
//  View+Destination.swift
//  Kinova
//
//  Created by Igor Camilo on 02.08.25.
//

import SwiftUI

extension View {
  func destination() -> some View {
    self.navigationDestination(for: Destination.self) {
      DestinationView(destination: $0)
    }
  }
}
