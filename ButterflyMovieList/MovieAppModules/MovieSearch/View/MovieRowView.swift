//
//  MovieRowView.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//


import SwiftUI
import SDWebImageSwiftUI

struct MovieRowView: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            // Poster Image
            WebImage(url: movie.posterURL)
                .resizable()
                .indicator(.activity) // Optional activity indicator while loading
                .scaledToFill()
                .frame(width: 100, height: 150)
                .clipped()
                .cornerRadius(12)

            // Movie Info
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(movie.releaseDate?.isEmpty == false ? movie.releaseDate! : "N/A")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(movie.overview)
                    .frame(maxWidth: .infinity)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(3)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
        )
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
