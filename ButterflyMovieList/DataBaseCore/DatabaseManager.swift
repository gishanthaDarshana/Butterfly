//
//  DatabaseManager.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//


import SwiftData
import Foundation

@MainActor
final class DBManager: DatabaseManagerProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - Save Movies for Query & Page
    func saveMovies(_ movies: [Movie], query: String, page: Int) async throws {
        // Remove existing entries for this query + page
        let existing = try context.fetch(
            FetchDescriptor<MovieEntity>(
                predicate: #Predicate { $0.query == query && $0.page == page }
            )
        )
        for entity in existing {
            context.delete(entity)
        }
        
        // Insert new movies
        for movie in movies {
            let entity = MovieEntity(from: movie, query: query, page: page)
            context.insert(entity)
        }
        
        try context.save()
    }
    
    // MARK: - Fetch All Movies for Query (All Pages)
    func fetchMovies(for query: String) async throws -> [Movie] {
        let descriptor = FetchDescriptor<MovieEntity>(
            predicate: #Predicate { $0.query == query },
            sortBy: [SortDescriptor(\.page)]
        )
        
        let entities = try context.fetch(descriptor)
        return entities.map { $0.toMovie() }
    }
    
    // MARK: - Fetch Movies for Query + Page
    func fetchMovies(for query: String, page: Int) async throws -> [Movie] {
        let descriptor = FetchDescriptor<MovieEntity>(
            predicate: #Predicate { $0.query == query && $0.page == page }
        )
        
        let entities = try context.fetch(descriptor)
        return entities.map { $0.toMovie() }
    }
    
    // MARK: - Clear Cached Movies for Query
    func clearMovies(for query: String) async throws {
        let descriptor = FetchDescriptor<MovieEntity>(
            predicate: #Predicate { $0.query == query }
        )
        
        let entities = try context.fetch(descriptor)
        for entity in entities {
            context.delete(entity)
        }
        
        try context.save()
    }
}



