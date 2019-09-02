//
//  MovieDetailPresenter.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 1/09/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import UIKit

protocol MovieDetailPresenterProtocol: class {
    
    var id: Int? { get set }
    var view: MovieDetailViewProtocol? { get set }
    var router: MovieDetailRouterProtocol! { get set }
    var interactor: MovieDetailInteractorProtocol! { get set }
    
    func viewDidLoad()
    
}

protocol MovieDetailInteractorOutputProtocol: class {
    func movieDetailDidFetch(movie: FullMovie)
    func failedGetMovieDetail(error: String)
    
    func movieDetailImageDidFetch(image: UIImage)
    func failedGetMovieDetailImage(error: String)
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var view: MovieDetailViewProtocol?
    var router: MovieDetailRouterProtocol!
    var interactor: MovieDetailInteractorProtocol!
    
    var id: Int?
    
    func viewDidLoad() {
        guard let id = id else {
            router.showAlert(for: "ERROR 404")
            return
        }
        interactor.getMovieInformation(id: id)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func movieDetailDidFetch(movie: FullMovie) {
        view?.displayMovieDetail(movie)
        if let path = movie.backdrop_path {
            interactor.getMovieImage(path: path)
        }
    }
    
    func failedGetMovieDetail(error: String) {
        router.showAlert(for: error)
    }
    
    func movieDetailImageDidFetch(image: UIImage) {
        view?.displayImage(image)
    }
    
    func failedGetMovieDetailImage(error: String) {
        router.showAlert(for: error)
    }
}
