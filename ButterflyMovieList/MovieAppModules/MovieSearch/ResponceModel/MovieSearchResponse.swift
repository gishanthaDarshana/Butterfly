//
//  MovieSearchResponse.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-15.
//


import Foundation

// MARK: - Search Response
struct MovieSearchResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie Model
struct Movie: Codable, Identifiable, Hashable {
    let objectID = UUID().uuidString
    let id: Int
    var title: String
    let originalTitle: String
    let overview: String
    let releaseDate: String?
    let posterPath: String?
    let backdropPath: String?
    let genreIDs: [Int]?
    let originalLanguage: String
    let adult: Bool?
    let video: Bool?
    let popularity: Double?
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case originalLanguage = "original_language"
        case adult
        case video
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Helpers
extension Movie {
    /// Full URL for the poster image
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    /// Full URL for the backdrop image
    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w780\(path)")
    }
    
    /// Readable release year (e.g. "2012")
    var releaseYear: String {
        guard let date = releaseDate, !date.isEmpty else { return "N/A" }
        return String(date.prefix(4))
    }
}
