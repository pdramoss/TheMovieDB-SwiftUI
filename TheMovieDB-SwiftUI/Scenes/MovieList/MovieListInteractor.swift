//
//  MovieListInteractor.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 31/08/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import Foundation

protocol MovieListInteractorProtocol: class {
    var output: MovieListInteractorOutputProtocol? { get set }
    var networkManager: NetworkManagerProtocol! { get set }
    
    func getMovieList(page: Int)
}

class MovieListInteractor: MovieListInteractorProtocol {
    var output: MovieListInteractorOutputProtocol?
    var networkManager: NetworkManagerProtocol! = NetworkManager()
    
    func getMovieList(page: Int) {
        networkManager.getPopularMovies(page: page) { (result) in
            switch result {
            case .success(let movieList):
                self.output?.movieListDidFetch(movies: movieList.results)
            case .failure(let error):
                self.output?.failedGetMovieList(error: error)
            }
        }
    }
}
