//
//  DatabaseManagerProtocol.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//

import Foundation


protocol DatabaseManagerProtocol {
    func saveMovies(_ movies: [Movie], query: String, page: Int) async throws
    func fetchMovies(for query: String) async throws -> [Movie]
    func fetchMovies(for query: String, page: Int) async throws -> [Movie]
    func clearMovies(for query: String) async throws
}
