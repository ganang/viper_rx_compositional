//
//  MovieDetailWireframe.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 20/02/21.
//

import UIKit

class MovieDetailWireframe: MovieDetailWireframeProtocol {
    
    class func createMainModule(movieDetailRef: MovieDetailViewController) {
        let presenter: MovieDetailPresenterProtocol = MovieDetailPresenter()
        
        movieDetailRef.presenter = presenter
        movieDetailRef.presenter?.wireframe = MovieDetailWireframe()
        movieDetailRef.presenter?.view = movieDetailRef
        movieDetailRef.presenter?.interactor = MovieDetailInteractor()
        movieDetailRef.presenter?.interactor?.presenter = presenter
    }

}

