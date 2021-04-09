//
//  MovieDetailPresenter.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 20/02/21.
//

import UIKit

class MovieDetailPresenter: MovieDetailPresenterProtocol {
   
    var interactor: MovieDetailInteractorProtocol?
    weak var view: MovieDetailViewControllerProtocol?
    var wireframe: MovieDetailWireframeProtocol?
    
    func getMovieDetail(withMovieId id: Int, withParams params: [String: Any]) {
        interactor?.getMovieDetail(withMovieId: id, withParams: params)
    }
    
    func getMovieReview(withMovieId id: Int, withParams params: [String: Any]) {
        interactor?.getMovieReview(withMovieId: id, withParams: params)
    }
    
    func displayMovieDetailSuccess(withResponse response: MovieDetailResponse) {
        view?.displayMovieDetailSuccess(withResponse: response)
    }
    
    func displayMovieDetailError(withError error: Error) {
        view?.displayMovieDetailError(withError: error)
    }
    
    func displayMovieReviewSuccess(withResponse response: ReviewResponse) {
        view?.displayMovieReviewSuccess(withResponse: response)
    }
    
    func displayMovieReviewError(withError error: Error) {
        view?.displayMovieReviewError(withError: error)
    }
    
}
