//
//  MovieListTableViewController.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 31/08/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import UIKit

protocol MovieListViewProtocol: class {
    var presenter: MovieListPresenterProtocol! { get set }
    var movies: [PreviewMovie] { get set }
    
    func showMovies(with movies: [PreviewMovie])
    func showMessageError(error: String)
}

class MovieListTableViewController: UITableViewController {
    
    var presenter: MovieListPresenterProtocol!
    var movies: [PreviewMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "THE MOVIE DB"
        //view.backgroundColor = .primary
        MovieListRouter.createMovieListModuler(movieListRef: self)
        tableView.register(MovieItemTableViewCell.nib, forCellReuseIdentifier: MovieItemTableViewCell.cellReuseIdentifier)
        presenter.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieItemTableViewCell.cellReuseIdentifier, for: indexPath) as? MovieItemTableViewCell else {
            return UITableViewCell()
        }
        cell.setupData(movie: movie)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showMovieDetailSelection(id: self.movies[indexPath.row].id)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
}

extension MovieListTableViewController: MovieListViewProtocol {
    func showMovies(with movies: [PreviewMovie]) {
        self.movies = movies
        tableView.reloadData()
    }
    
    func showMessageError(error: String) {
        print("ERROR: \(error)")
    }
}

extension MovieListTableViewController {
    static var storyboardID: String {
        return String(describing: self)
    }
}
