//
//  RootViewModelTests.swift
//  Kinova
//
//  Created by Igor Camilo on 19.08.25.
//  Copyright © 2025 Igor Camilo. All rights reserved.
//

import TMDB
import Testing

@testable import Kinova

struct RootViewModelTests {
  @Test func `Test generation of simplest restoration data`() throws {
    let viewModel1 = RootViewModel()
    let viewModel2 = RootViewModel()
    let data = try #require(viewModel1.restorationData())
    viewModel2.restoreData(from: data)
    #expect(viewModel1.homePath == viewModel2.homePath)
    #expect(viewModel1.searchPath == viewModel2.searchPath)
    #expect(viewModel1.selectedTab == viewModel2.selectedTab)
  }

  @Test func `Test generation of complex restoration data`() throws {
    let viewModel1 = RootViewModel()
    viewModel1.homePath = (0..<5).map {
      Destination.genre(id: Genre.ID(rawValue: $0), title: "Genre \($0)")
    }
    viewModel1.searchPath = (0..<5).map {
      Destination.keyword(id: Keyword.ID(rawValue: $0), title: "Keyword \($0)")
    }
    viewModel1.selectedTab = .search
    let viewModel2 = RootViewModel()
    #expect(viewModel1.homePath != viewModel2.homePath)
    #expect(viewModel1.searchPath != viewModel2.searchPath)
    #expect(viewModel1.selectedTab != viewModel2.selectedTab)
    let data = try #require(viewModel1.restorationData())
    viewModel2.restoreData(from: data)
    #expect(viewModel1.homePath == viewModel2.homePath)
    #expect(viewModel1.searchPath == viewModel2.searchPath)
    #expect(viewModel1.selectedTab == viewModel2.selectedTab)
  }
}
