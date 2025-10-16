//
//  MovieSearchService.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//

import Foundation

class MovieSearchService: MovieSearchProtocol {
    
    let network : ButterflyHTTPProtocol
    
    init(network: ButterflyHTTPProtocol = NetworkManager()) {
        self.network = network
    }
    
    func fetchMovies(query: String, page: Int) async throws -> MovieSearchResult {
        
        let url = "/search/movie"
        let parameters: [String: Any] = ["query": query, "page": page]
        
        do {
            let responce : MovieSearchResponse = try await network.request(url: url, method: .get, parameters: parameters, headers: nil, encoding: nil)
            return .success(responce)
        } catch let error as NetworkError {
            throw MovieSearchError.networkError(error: error)
        } catch {
           throw MovieSearchError.invalidResponse
        }
    }
}
