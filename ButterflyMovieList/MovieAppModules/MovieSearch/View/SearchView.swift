//
//  SearchView.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//


import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = MovieSearchViewModel()
    
    var body: some View {
            NavigationView {
                VStack {
                    // Search Bar
                    TextField("Search movies...", text: $viewModel.movieSearchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
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
            }
            .onAppear {
                viewModel.startListningForSearchTextChanges()
            }
        }
   
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
