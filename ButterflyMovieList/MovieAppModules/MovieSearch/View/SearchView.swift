//
//  SearchView.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//


import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel : MovieSearchViewModel
    
    init(viewModel: MovieSearchViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            NavigationView {
                VStack {
                    // Search Bar
                    MovieSearchBar(text: $viewModel.movieSearchQuery, placeholder: "Search movies...")
                    
                    // Movie List
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.movies, id: \.id) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieRowView(movie: movie)
                                        .onAppear {
                                            Task {
                                                await viewModel.searchMovies(query: viewModel.movieSearchQuery)
                                            }
                                        }
                                }
                                .buttonStyle(PlainButtonStyle()) // removes default nav link highlight
                            }
                            
                            if viewModel.isLoading {
                                ProgressView()
                                    .padding()
                            }
                        }
                    }
                }
                .navigationTitle("Movie Search")
                .toast(isPresented: $viewModel.showErrorToast, message: viewModel.errorMessage)
                    
            }
            .onAppear {
                viewModel.startListningForSearchTextChanges()
            }
        }
   
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: MovieSearchViewModel(repository: MockMovieRepo()))
    }
}

class MockMovieRepo : MovieRepositoryProtocol {
    func getMovies(query: String, page: Int) async throws -> MovieSearchResult {
        return .success(MovieSearchResponse(page: 1, results: [], totalPages: 1, totalResults: 1))
    }
}
