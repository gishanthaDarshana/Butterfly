//
//  MovieRepositoryUnitTests.swift
//  ButterflyMovieListTests
//
//  Created by Gishantha Darshana on 2025-10-16.
//

import Testing
@testable import ButterflyMovieList
struct MovieRepositoryUnitTests {

    @Test func testMoviesFetchedFromNetworkAndSavedToDB() async throws {
        let expectedMovies = [Movie(id: 1, title: "Test", originalTitle: "Test", overview: "Some overview", releaseDate: "2022-10-16", posterPath: "", backdropPath: "", genreIDs: nil, originalLanguage: "en", adult: nil, video: nil, popularity: 0.0, voteAverage: 2, voteCount: 3)]
        let response = MovieSearchResponse(page: 1, results: expectedMovies, totalPages: 1, totalResults: 1)
        
        let repo = MockMovieRepositoryProtocol()
        repo.result = .success(response)
        
        let movies = await repo.getMovies(query: "Test", page: 1)
        switch movies {
        case .success(let movieList):
            #expect(movieList.results.count != 0 , "Movies should be fetched from network")
        case .failure(let error):
            #expect(Bool(false), "Should not fail: \(error)")
        }
    }
    
    @Test func testMoviesFetchedFromDBWhenOffline() async throws {
        let expectedMovies = [Movie(id: 2, title: "Offline", originalTitle: "Offline", overview: "Offline overview", releaseDate: "2022-10-17", posterPath: "", backdropPath: "", genreIDs: nil, originalLanguage: "en", adult: nil, video: nil, popularity: 0.0, voteAverage: 3, voteCount: 4)]
        let response = MovieSearchResponse(page: 1, results: expectedMovies, totalPages: 1, totalResults: 1)
        
        let repo = MockMovieRepositoryProtocol()
        repo.result = .success(response)
        
        let movies = await repo.getMovies(query: "Offline", page: 1)
        switch movies {
        case .success(let movieList):
            #expect(movieList.results.count == expectedMovies.count, "Movies should be fetched from DB when offline")
        case .failure(let error):
            #expect(Bool(false), "Should not fail: \(error)")
        }
    }

    @Test func testFallbackToDBOnNetworkError() async throws {
        let repo = MockMovieRepositoryProtocol()
        repo.result = .failure(.invalidResponse)
        
        let movies = await repo.getMovies(query: "Cached", page: 1)
        switch movies {
        case .success(_):
            #expect(Bool(false), "Should not succeed when network error and no cache")
        case .failure(let error):
            
            switch error {
            case .invalidResponse:
                #expect(Bool(true), "Should fail with invalid response error")
            default:
                #expect(Bool(false), "Should fail with invalid response error")
            }
        }
    }

    @Test func testFailureWhenNoDataAvailable() async throws {
        let repo = MockMovieRepositoryProtocol()
        repo.result = .failure(.noData)
        
        let movies = await repo.getMovies(query: "Empty", page: 1)
        switch movies {
        case .success(_):
            #expect(Bool(false), "Should not succeed when no data available")
        case .failure(let error):
            switch error {
            case .noData:
                #expect(Bool(true), "Should fail with no data error")
            default:
                #expect(Bool(false), "Should fail with no data error")
            }
        }
    }

}

final class MockMovieRepositoryProtocol: MovieRepositoryProtocol {
    var result: MovieSearchResult!
    
    func getMovies(query: String, page: Int) async -> MovieSearchResult {
        return result
    }
}

