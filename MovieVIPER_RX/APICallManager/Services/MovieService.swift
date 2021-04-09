//
//  MovieService.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 16/02/21.
//

import UIKit

protocol MovieService {
    
    // get popular movie
    func getPopularMovies(endpoint: MovieEndPoint , params: [String: Any]?, onSuccess: @escaping (_ response: MovieResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
    // get top rated movie
    func getTopRatedMovies(endpoint: MovieEndPoint , params: [String: Any]?, onSuccess: @escaping (_ response: MovieResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
    // get now playing movie
    func getNowPlayingMovies(endpoint: MovieEndPoint , params: [String: Any]?, onSuccess: @escaping (_ response: MovieResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
    // get movie detail
    func getMovieDetail(id: Int , params: [String: Any]?, onSuccess: @escaping (_ response: MovieDetailResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
    // get movie review
    func getMovieReview(id: Int , params: [String: Any]?, onSuccess: @escaping (_ response: ReviewResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
}

public enum MovieEndPoint: String, CaseIterable, Identifiable {
    
    public var id: String { self.rawValue }
    
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    case popular
}

public enum MovieError: Error {
    case errorFromApi
    case noData
    case invalidEndpoint
    case invalidResponse
    case serializationError
}
