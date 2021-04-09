//
//  MovieDetailInteractor.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 20/02/21.
//

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    weak var presenter: MovieDetailPresenterProtocol?
    
    func getMovieDetail(withMovieId id: Int, withParams params: [String: Any]) {
        MovieProvider.shared.getMovieDetail(id: id, params: params) { (MovieDetailResponse) in
            self.presenter?.displayMovieDetailSuccess(withResponse: MovieDetailResponse)
        } onError: { (Error) in
            self.presenter?.displayMovieDetailError(withError: Error)
        }
    }
    
    func getMovieReview(withMovieId id: Int, withParams params: [String : Any]) {
        MovieProvider.shared.getMovieReview(id: id, params: params) { (ReviewResponse) in
            self.presenter?.displayMovieReviewSuccess(withResponse: ReviewResponse)
        } onError: { (Error) in
            self.presenter?.displayMovieReviewError(withError: Error)
        }
    }
    
}
