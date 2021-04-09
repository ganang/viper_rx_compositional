//
//  MovieDetailProtocol.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 20/02/21.
//

import UIKit

protocol MovieDetailViewControllerProtocol: class {
    func displayMovieDetailSuccess(withResponse response: MovieDetailResponse)
    func displayMovieDetailError(withError error: Error)
    func displayMovieReviewSuccess(withResponse response: ReviewResponse)
    func displayMovieReviewError(withError error: Error)
}

protocol MovieDetailPresenterProtocol: class {
    var interactor: MovieDetailInteractorProtocol? { get set }
    var view: MovieDetailViewControllerProtocol? { get set }
    var wireframe: MovieDetailWireframeProtocol? { get set }
    
    func getMovieDetail(withMovieId id: Int, withParams params: [String: Any])
    func getMovieReview(withMovieId id: Int, withParams params: [String: Any])
    
    func displayMovieDetailSuccess(withResponse response: MovieDetailResponse)
    func displayMovieDetailError(withError error: Error)
    func displayMovieReviewSuccess(withResponse response: ReviewResponse)
    func displayMovieReviewError(withError error: Error)
}

protocol MovieDetailInteractorProtocol: class {
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func getMovieDetail(withMovieId id: Int, withParams params: [String: Any])
    func getMovieReview(withMovieId id: Int, withParams params: [String: Any])
}

protocol MovieDetailWireframeProtocol: class {
}




