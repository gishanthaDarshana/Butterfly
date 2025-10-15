//
//  MovieSearchViewModel.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//

import Foundation
import Combine

@MainActor
class MovieSearchViewModel : ObservableObject {
    @Published var isLoading: Bool = false
    @Published var movies: [Movie] = []
    @Published var movieSearchQuery : String = ""
    
    var cancellables = Set<AnyCancellable>()
    var currentPage: Int = 1
    var movieService : MovieSearchProtocol
    
    init(movieService: MovieSearchProtocol = MovieSearchService()) {
        self.movieService = movieService
    }
    
    func startListningForSearchTextChanges() {
        $movieSearchQuery.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                self.currentPage = 1
                self.movies = []
                Task {
                    await self.searchMovies(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    func searchMovies(query: String) async {
        guard !query.isEmpty else {
            self.isLoading = false
            return
        }
        do {
            self.isLoading = true
            
            let moviesResult = try await movieService.fetchMovies(query: query, page: currentPage)
            
            switch moviesResult {
            case .success(let response):
                self.isLoading = false
                if currentPage <= response.totalPages && response.totalResults > self.movies.count {
                    currentPage += 1
                    self.movies.append(contentsOf: response.results)
                }
                
            case .failure(let error):
                self.isLoading = false
                switch error {
                case .invalidResponse:
                    print("Invalid Response")
                case .noData:
                    print("No Data Available")
                case .networkError(error: let error):
                    print("Network Error: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Unexpected Error: \(error)")
        }
    }
    
    
}

