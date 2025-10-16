//
//  MovieDetailView.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//


import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Backdrop
                MovieBackdropView(url: movie.backdropURL)
                    .isVisible(Binding (get: {
                        movie.backdropURL != nil
                    }, set: { value in
                        
                    }))

                // Poster + Info
                HStack(alignment: .top, spacing: 16) {
                    MoviePosterView(url: movie.posterURL)
                        .frame(width: 120, height: 180)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .lineLimit(2)

                        Text("Release: \(movie.releaseDate?.isEmpty == false ? movie.releaseDate! : "N/A")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        RatingView(rating: movie.voteAverage)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)

                // Overview
                VStack(alignment: .leading, spacing: 8) {
                    Text("Overview")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .padding(.bottom, 4)
                    Text(movie.overview)
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)

                Spacer(minLength: 20)
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Subviews
import SDWebImageSwiftUI
struct MovieBackdropView: View {
    let url: URL?

    var body: some View {
        WebImage(url: url)
            .resizable()
            .indicator(.activity) // Optional activity indicator while loading
            .frame(height : 250)
            .clipped()
    }
}

struct MoviePosterView: View {
    let url: URL?

    var body: some View {
        WebImage(url: url, isAnimating: .constant(true)) { image in
            image
                .resizable()
                .scaledToFill()
                .cornerRadius(12)
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(12)
        }

    }
}

struct RatingView: View {
    let rating: Double

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
                .font(.caption)
            Text(String(format: "%.1f", rating))
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
