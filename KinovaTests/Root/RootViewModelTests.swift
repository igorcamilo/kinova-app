//
//  RootViewModelTests.swift
//  Kinova
//
//  Created by Igor Camilo on 19.08.25.
//  Copyright © 2025 Igor Camilo. All rights reserved.
//

@testable import Kinova
import Testing
import TMDB

struct RootViewModelTests {
  @Test func `Test generation of simplest restoration data`() throws {
    let viewModel1 = RootViewModel()
    let viewModel2 = RootViewModel()
    let data = try #require(viewModel1.restorationData())
    viewModel2.restoreData(from: data)
    #expect(viewModel1.homePath == viewModel2.homePath)
    #expect(viewModel1.listsPath == viewModel2.listsPath)
    #expect(viewModel1.moviesPath == viewModel2.moviesPath)
    #expect(viewModel1.tvShowsPath == viewModel2.tvShowsPath)
    #expect(viewModel1.searchPath == viewModel2.searchPath)
    #expect(viewModel1.selectedTab == viewModel2.selectedTab)
  }

  @Test func `Test generation of complex restoration data`() throws {
    let viewModel1 = RootViewModel()
    viewModel1.homePath = (0..<5).map {
      Destination.genre(id: Genre.ID(rawValue: $0), title: "Genre \($0)")
    }
    viewModel1.listsPath = (0..<5).map {
      Destination.keyword(id: Keyword.ID(rawValue: $0), title: "Keyword \($0)")
    }
    viewModel1.moviesPath = (0..<5).map {
      Destination.movie(id: Movie.ID(rawValue: $0), title: "Movie \($0)")
    }
    viewModel1.tvShowsPath = (0..<5).map {
      Destination.tvShow(id: TVShow.ID(rawValue: $0), title: "TV Show \($0)")
    }
    viewModel1.searchPath = (0..<5).map {
      Destination.genre(id: Genre.ID(rawValue: $0), title: "Genre \($0)")
    }
    viewModel1.selectedTab = .search
    let viewModel2 = RootViewModel()
    #expect(viewModel1.homePath != viewModel2.homePath)
    #expect(viewModel1.listsPath != viewModel2.listsPath)
    #expect(viewModel1.moviesPath != viewModel2.moviesPath)
    #expect(viewModel1.tvShowsPath != viewModel2.tvShowsPath)
    #expect(viewModel1.searchPath != viewModel2.searchPath)
    #expect(viewModel1.selectedTab != viewModel2.selectedTab)
    let data = try #require(viewModel1.restorationData())
    viewModel2.restoreData(from: data)
    #expect(viewModel1.homePath == viewModel2.homePath)
    #expect(viewModel1.listsPath == viewModel2.listsPath)
    #expect(viewModel1.moviesPath == viewModel2.moviesPath)
    #expect(viewModel1.tvShowsPath == viewModel2.tvShowsPath)
    #expect(viewModel1.searchPath == viewModel2.searchPath)
    #expect(viewModel1.selectedTab == viewModel2.selectedTab)
  }
}
