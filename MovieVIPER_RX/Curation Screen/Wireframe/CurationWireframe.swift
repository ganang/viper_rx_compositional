//
//  CurationWireframe.swift
//  MovieVIPER_RX
//
//  Created by Ganang Arief Pratama on 18/02/21.
//

import UIKit

class CurationWireframe: CurationWireframeProtocol {
    
    class func createMainModule(curationRef: CurationViewController) {
        let presenter: CurationPresenterProtocol = CurationPresenter()
        
        curationRef.presenter = presenter
        curationRef.presenter?.wireframe = CurationWireframe()
        curationRef.presenter?.view = curationRef
        curationRef.presenter?.interactor = CurationInteractor()
        curationRef.presenter?.interactor?.presenter = presenter
    }

}

