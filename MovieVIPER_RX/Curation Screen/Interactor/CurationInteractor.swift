//
//  CurationInteractor.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 18/02/21.
//

class CurationInteractor: CurationInteractorProtocol {
    
    weak var presenter: CurationPresenterProtocol?
    
    func getPopularMovies(withParams params: [String : Any]) {
        MovieProvider.shared.getPopularMovies(endpoint: .popular, params: params) { (response) in
            self.presenter?.displayPopularMoviesSuccess(withResponse: response)
        } onError: { (error) in
            self.presenter?.displayPopularMoviesError(withError: error)
        }
    }
    
    func getTopRatedMovies(withParams params: [String : Any]) {
        MovieProvider.shared.getTopRatedMovies(endpoint: .topRated, params: params) { (response) in
            self.presenter?.displayTopRatedMoviesSuccess(withResponse: response)
        } onError: { (error) in
            self.presenter?.displayTopRatedMoviesError(withError: error)
        }
    }
    
    func getNowPlayingMovies(withParams params: [String : Any]) {
        MovieProvider.shared.getNowPlayingMovies(endpoint: .nowPlaying, params: params) { (response) in
            self.presenter?.displayNowPlayingMoviesSuccess(withResponse: response)
        } onError: { (error) in
            self.presenter?.displayNowPlayingMoviesError(withError: error)
        }
    }
}
