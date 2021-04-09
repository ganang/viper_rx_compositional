//
//  MovieDetailResponse.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 22/02/21.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetailResponse: Codable {
    let adult: Bool
    let backdropPath: String?
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbId, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage:Double
    let voteCount: Int
    
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let name: String
}


