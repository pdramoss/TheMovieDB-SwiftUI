//
//  MovieListPresenter.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 31/08/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import Foundation

protocol MovieListPresenterProtocol: class {
    var view: MovieListViewProtocol? { get set }
    var router: MovieListRouterProtocol! { get set }
    var interactor: MovieListInteractorProtocol! { get set }
    
    func viewDidLoad()
    func showMovieDetailSelection(id: Int)
    
}

protocol MovieListInteractorOutputProtocol: class {
    func movieListDidFetch(movies: [PreviewMovie])
    func failedGetMovieList(error: String)
}

class MovieListPresenter: MovieListPresenterProtocol {
    var view: MovieListViewProtocol?
    var router: MovieListRouterProtocol!
    var interactor: MovieListInteractorProtocol!
    
    func viewDidLoad() {
        interactor.getMovieList(page: 1)
    }
    
    func showMovieDetailSelection(id: Int) {
        router.pushToMovieDetail(id: id)
    }
}

extension MovieListPresenter: MovieListInteractorOutputProtocol {
    func movieListDidFetch(movies: [PreviewMovie]) {
        view?.showMovies(with: movies)
    }
    
    func failedGetMovieList(error: String) {
        view?.showMessageError(error: error)
        router.showAlert(for: error)
    }
}
