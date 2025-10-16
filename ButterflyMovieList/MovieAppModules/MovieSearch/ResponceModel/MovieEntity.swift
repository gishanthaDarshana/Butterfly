//
//  MovieEntity.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//


import SwiftData
import Foundation

@Model
final class MovieEntity {
    @Attribute(.unique) var id: Int
    var title: String
    var originalTitle: String
    var overview: String
    var releaseDate: String?
    var posterPath: String?
    var query: String
    var page: Int
    
    init(from movie: Movie, query: String, page: Int) {
        self.id = movie.id
        self.title = movie.title
        self.originalTitle = movie.originalTitle
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.posterPath = movie.posterPath
        self.query = query
        self.page = page
    }
}

extension MovieEntity {
    func toMovie() -> Movie {
        Movie(
            id: id,
            title: title,
            originalTitle: originalTitle,
            overview: overview,
            releaseDate: releaseDate,
            posterPath: posterPath,
            backdropPath: nil,
            genreIDs: nil,
            originalLanguage: "en",
            adult: false,
            video: false,
            popularity: nil,
            voteAverage: 0,
            voteCount: 0
        )
    }
}

