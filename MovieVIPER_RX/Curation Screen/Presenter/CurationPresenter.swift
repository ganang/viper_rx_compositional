//
//  CurationPresenter.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 18/02/21.
//

import UIKit

class CurationPresenter: CurationPresenterProtocol {
   
    var interactor: CurationInteractorProtocol?
    weak var view: CurationViewControllerProtocol?
    var wireframe: CurationWireframeProtocol?
    
    func getPopularMovies(withParams params: [String : Any]) {
        interactor?.getPopularMovies(withParams: params)
    }
    
    func displayPopularMoviesSuccess(withResponse response: MovieResponse) {
        view?.displayPopularMoviesSuccess(withResponse: response)
    }
    
    func displayPopularMoviesError(withError error: Error) {
        view?.displayPopularMoviesError(withError: error)
    }
    
    func getTopRatedMovies(withParams params: [String : Any]) {
        interactor?.getTopRatedMovies(withParams: params)
    }
    
    func displayTopRatedMoviesSuccess(withResponse response: MovieResponse) {
        view?.displayTopRatedMoviesSuccess(withResponse: response)
    }
    
    func displayTopRatedMoviesError(withError error: Error) {
        view?.displayTopRatedMoviesError(withError: error)
    }
    
    func getNowPlayingMovies(withParams params: [String : Any]) {
        interactor?.getNowPlayingMovies(withParams: params)
    }
    
    func displayNowPlayingMoviesSuccess(withResponse response: MovieResponse) {
        view?.displayNowPlayingMoviesSuccess(withResponse: response)
    }
    
    func displayNowPlayingMoviesError(withError error: Error) {
        view?.displayNowPlayingMoviesError(withError: error)
    }
    
}

