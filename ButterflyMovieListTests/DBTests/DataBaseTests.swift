//
//  DataBaseTests.swift
//  ButterflyMovieListTests
//
//  Created by Gishantha Darshana on 2025-10-17.
//

import Testing
@testable import ButterflyMovieList

final class MockDatabaseManager: DatabaseManagerProtocol {
    var savedMovies: [(movies: [Movie], query: String, page: Int)] = []
    var fetchedQuery: String?
    var fetchedPage: Int?
    var clearedQuery: String?
    var fetchResult: [Movie] = []

    func saveMovies(_ movies: [Movie], query: String, page: Int) async throws {
        savedMovies.append((movies, query, page))
    }

    func fetchMovies(for query: String) async throws -> [Movie] {
        fetchedQuery = query
        return fetchResult
    }

    func fetchMovies(for query: String, page: Int) async throws -> [Movie] {
        fetchedQuery = query
        fetchedPage = page
        return fetchResult
    }

    func clearMovies(for query: String) async throws {
        clearedQuery = query
    }
}
struct DataBaseTests {

    @Test func testSaveMovies() async throws {
        let mock = MockDatabaseManager()
        let movies = [Movie(id: 1, title: "action", originalTitle: "Saving", overview: "Saving Overview", releaseDate: nil, posterPath: nil, backdropPath: nil, genreIDs: nil, originalLanguage: "En", adult: nil, video: nil, popularity: nil, voteAverage: 2.0, voteCount: 4)]
        try await mock.saveMovies(movies, query: "action", page: 1)
        #expect(mock.savedMovies.count == 1)
        #expect(mock.savedMovies.first?.query == "action")
    }

    @Test func testFetchMovies() async throws {
        let mock = MockDatabaseManager()
        mock.fetchResult = [Movie(id: 1, title: "Fetched", originalTitle: "Saving", overview: "Saving Overview", releaseDate: "2024-01-01", posterPath: nil, backdropPath: nil, genreIDs: nil, originalLanguage: "En", adult: nil, video: nil, popularity: nil, voteAverage: 2.0, voteCount: 4)]
        let result = try await mock.fetchMovies(for: "comedy")
        #expect(mock.fetchedQuery == "comedy")
        #expect(result.count == 1)
        #expect(result.first?.title == "Fetched")
    }

    @Test func testFetchMoviesWithPage() async throws {
        let mock = MockDatabaseManager()
        mock.fetchResult = [Movie(id: 3, title: "Paged", originalTitle: "Saving", overview: "Overview", releaseDate: "2024-01-01", posterPath: nil, backdropPath: nil, genreIDs: nil, originalLanguage: "En", adult: nil, video: nil, popularity: nil, voteAverage: 2.0, voteCount: 4)]
        let result = try await mock.fetchMovies(for: "drama", page: 2)
        #expect(mock.fetchedQuery == "drama")
        #expect(mock.fetchedPage == 2)
        #expect(result.first?.id == 3)
    }

    @Test func testClearMovies() async throws {
        let mock = MockDatabaseManager()
        try await mock.clearMovies(for: "horror")
        #expect(mock.clearedQuery == "horror")
    }

}
