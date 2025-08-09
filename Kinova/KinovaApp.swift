//
//  KinovaApp.swift
//  Kinova
//
//  Created by Igor Camilo on 12.07.25.
//

import SwiftUI

@main struct KinovaApp: App {
  @State private var configuration = Configuration()

  var body: some Scene {
    WindowGroup {
      RootView()
        .environment(configuration)
        #if os(macOS)
          .frame(minHeight: 375)
        #endif
    }
  }
}
