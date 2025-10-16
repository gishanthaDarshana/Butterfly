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
    @Published var showErrorToast: Bool = false
    @Published var errorMessage: String = ""
    
    var cancellables = Set<AnyCancellable>()
    var currentPage: Int = 1
    private let repository: MovieRepositoryProtocol
        
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
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
    
    func searchMovies(query: String, page: Int = 1) async {
        self.showErrorToast = false
        guard !query.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }
        
        do {
            self.isLoading = true
            
            let moviesResult = try await repository.getMovies(query: query, page: currentPage)
            
            switch moviesResult {
            case .success(let response):
                self.isLoading = false
                if currentPage <= response.totalPages && response.totalResults > self.movies.count {
                    currentPage += 1
                    self.movies.append(contentsOf: response.results)
                }
                
            case .failure(let error):
                self.isLoading = false
                self.showErrorToast = true
                switch error {
                case .invalidResponse:
                    errorMessage = "Invalid Response from server."
                case .noData:
                    errorMessage = "Invalid Response from server."
                case .networkError(error: let error):
                    errorMessage = "Network Error: \(error.localizedDescription)"
                }
            }
        } catch {
            self.isLoading = false
            self.showErrorToast = true
            errorMessage = "Unexpected Error: \(error)"
        }
    }
    
}

