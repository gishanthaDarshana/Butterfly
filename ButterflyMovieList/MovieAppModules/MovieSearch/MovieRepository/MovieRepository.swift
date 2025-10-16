//
//  MovieRepository.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//


protocol MovieRepositoryProtocol {
    func getMovies(query: String, page: Int) async throws -> MovieSearchResult
}


final class MovieRepository: MovieRepositoryProtocol {
    private let network: MovieSearchProtocol
    private let dbManager: DatabaseManagerProtocol
    private let networkMonitor: NetworkMonitorProtocol
    
    init(network: MovieSearchProtocol,
         dbManager: DatabaseManagerProtocol,
         networkMonitor: NetworkMonitorProtocol) {
        self.network = network
        self.dbManager = dbManager
        self.networkMonitor = networkMonitor
    }
    
    func getMovies(query: String, page: Int) async -> MovieSearchResult {
        if networkMonitor.isConnected {
            do {
                let result = try await network.fetchMovies(query: query, page: page)
                
                switch result {
                case .success(let response):
                    // Save to DB for offline access
                    try await dbManager.saveMovies(response.results, query: query, page: page)
                    return .success(response)
                    
                case .failure(let error):
                    // fallback to cache if available
                    let cachedResponse = await fetchCachedMovies(for: query)
                    if let cachedResponse = cachedResponse {
                        return .success(cachedResponse)
                    } else {
                        return .failure(error)
                    }
                }
            } catch {
                // Handle unexpected errors
                let cachedResponse = await fetchCachedMovies(for: query)
                if let cachedResponse = cachedResponse {
                    return .success(cachedResponse)
                } else {
                    return .failure(.invalidResponse)
                }
            }
        } else {
            // Offline → serve from DB
            if let cachedResponse = await fetchCachedMovies(for: query) {
                return .success(cachedResponse)
            } else {
                return .failure(.noData)
            }
        }
    }
        
    // MARK: - Helpers
    private func fetchCachedMovies(for query: String) async -> MovieSearchResponse? {
        do {
            let cachedMovies = try await dbManager.fetchMovies(for: query)
            guard !cachedMovies.isEmpty else { return nil }
            
            return MovieSearchResponse(
                page: 1,
                results: cachedMovies,
                totalPages: 1,
                totalResults: cachedMovies.count
            )
        } catch {
            return nil
        }
    }
}
