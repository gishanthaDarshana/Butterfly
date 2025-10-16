//
//  ButterflyMovieListApp.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-15.
//

import SwiftUI
import SwiftData

@main
struct ButterflyMovieListApp: App {
    var sharedModelContainer: ModelContainer = {
            let schema = Schema([MovieEntity.self])
            let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            return try! ModelContainer(for: schema, configurations: [config])
    }()

    var body: some Scene {
        WindowGroup {
            let context = sharedModelContainer.mainContext
            
            let dbManager = DBManager(context: context)
            let network = MovieSearchService()
            let networkMonitor = DefaultNetworkMonitor()
            
            let repository = MovieRepository(
                network: network,
                dbManager: dbManager,
                networkMonitor: networkMonitor
            )
            
            let viewModel = MovieSearchViewModel(repository: repository)
            
            SearchView(viewModel: viewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
