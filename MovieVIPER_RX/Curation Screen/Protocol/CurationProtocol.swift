//
//  CurationProtocol.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 18/02/21.
//

import UIKit

protocol CurationViewControllerProtocol: class {
    
    func displayPopularMoviesSuccess(withResponse response: MovieResponse)
    func displayPopularMoviesError(withError error: Error)
    func displayTopRatedMoviesSuccess(withResponse response: MovieResponse)
    func displayTopRatedMoviesError(withError error: Error)
    func displayNowPlayingMoviesSuccess(withResponse response: MovieResponse)
    func displayNowPlayingMoviesError(withError error: Error)
}

protocol CurationPresenterProtocol: class {
    var interactor: CurationInteractorProtocol? { get set }
    var view: CurationViewControllerProtocol? { get set }
    var wireframe: CurationWireframeProtocol? { get set }
    
    func getPopularMovies(withParams params: [String: Any])
    func getTopRatedMovies(withParams params: [String: Any])
    func getNowPlayingMovies(withParams params: [String: Any])
    
    func displayPopularMoviesSuccess(withResponse response: MovieResponse)
    func displayPopularMoviesError(withError error: Error)
    func displayTopRatedMoviesSuccess(withResponse response: MovieResponse)
    func displayTopRatedMoviesError(withError error: Error)
    func displayNowPlayingMoviesSuccess(withResponse response: MovieResponse)
    func displayNowPlayingMoviesError(withError error: Error)
}

protocol CurationInteractorProtocol: class {
    var presenter: CurationPresenterProtocol? { get set }
    
    func getPopularMovies(withParams params: [String: Any])
    func getTopRatedMovies(withParams params: [String: Any])
    func getNowPlayingMovies(withParams params: [String: Any])
}

protocol CurationWireframeProtocol: class {
}

