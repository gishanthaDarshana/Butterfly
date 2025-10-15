//
//  MovieSearchProtocol.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-15.
//

import Foundation

typealias MovieSearchResult = Result<MovieSearchResponse, MovieSearchError>

enum MovieSearchError: Error {
    case invalidResponse
    case noData
    case networkError(error : NetworkError)
}

protocol MovieSearchProtocol {
    func fetchMovies(query: String, page: Int) async throws -> MovieSearchResult
}
