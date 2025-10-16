//
//  MovieSearchError.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//


enum MovieSearchError: Error {
    case invalidResponse
    case noData
    case networkError(error : NetworkError)
}