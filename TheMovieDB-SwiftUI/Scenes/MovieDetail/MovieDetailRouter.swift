//
//  MovieDetailRouter.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 1/09/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import UIKit

protocol MovieDetailRouterProtocol: class {
    var viewController: UIViewController? { get set }
    func showAlert(for error: String)
}

class MovieDetailRouter: MovieDetailRouterProtocol {
    var viewController: UIViewController?
    
    class func createMovieDetailModuler(movieDetailRef: MovieDetailViewController, id: Int) {
        let presenter: MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter()
        presenter.id = id
        
        let router = MovieDetailRouter()
        router.viewController = movieDetailRef
        
        let interactor = MovieDetailInteractor()
        interactor.output = presenter
        
        presenter.view = movieDetailRef
        presenter.router = router
        presenter.interactor = interactor
        
        movieDetailRef.presenter = presenter
    }
    
    func showAlert(for error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: { (_) in
            self.viewController?.dismiss(animated: true, completion: nil)
        }))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
