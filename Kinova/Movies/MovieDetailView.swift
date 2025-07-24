//
//  MovieDetailView.swift
//  Kinova
//
//  Created by Igor Camilo on 23.07.25.
//

import SwiftUI

struct MovieDetailView: View {
    let viewModel: MovieDetailViewModel

    var body: some View {
        Text("Movie ID: \(viewModel.id.rawValue)")
            .navigationTitle("Movie Detail")
    }
}

#Preview {
    NavigationStack {
        MovieDetailView(
            viewModel: MovieDetailViewModel(
                id: .init(rawValue: 1)
            )
        )
    }
}
