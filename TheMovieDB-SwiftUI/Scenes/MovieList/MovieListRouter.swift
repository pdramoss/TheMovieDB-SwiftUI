//
//  MovieListRouter.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 31/08/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import UIKit

protocol MovieListRouterProtocol: class {
    var viewController: UIViewController? { get set }

    func showAlert(for error: String)
    func pushToMovieDetail(id: Int)
}

class MovieListRouter: MovieListRouterProtocol {
    var viewController: UIViewController?
    
    class func createMovieListModuler(movieListRef: MovieListTableViewController) {
        let presenter: MovieListPresenterProtocol & MovieListInteractorOutputProtocol = MovieListPresenter()
        
        let router = MovieListRouter()
        router.viewController = movieListRef
        
        let interactor = MovieListInteractor()
        interactor.output = presenter
        
        presenter.view = movieListRef
        presenter.router = router
        presenter.interactor = interactor
        
        movieListRef.presenter = presenter
    }
    
    func showAlert(for error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func pushToMovieDetail(id: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let movieDetailViewController = storyboard.instantiateViewController(withIdentifier: MovieDetailViewController.storyboardID) as! MovieDetailViewController
        MovieDetailRouter.createMovieDetailModuler(movieDetailRef: movieDetailViewController, id: id)
        viewController?.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
