//
//  NetworkError.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-15.
//
import Alamofire
import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case afError(AFError)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .invalidResponse:
            return "The server response was invalid."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .afError(let error):
            return "Network request failed: \(error.localizedDescription)"
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
