//
//  MovieDetailViewController.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 1/09/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import UIKit

protocol MovieDetailViewProtocol: class {
    var presenter: MovieDetailPresenterProtocol! { get set }
    func displayMovieDetail(_ movie: FullMovie)
    func displayImage(_ image: UIImage)
}

class MovieDetailViewController: UIViewController {

    @IBOutlet private weak var backdropPathImage: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var originalTitleLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var taglineLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    
    var presenter: MovieDetailPresenterProtocol!
    var movie: FullMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .primary
        presenter.viewDidLoad()
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func displayMovieDetail(_ movie: FullMovie) {
        self.movie = movie
        title = movie.title
        originalTitleLabel.text = "TITULO ORIGINAL: \(movie.original_title)"
        statusLabel.text = "ESTADO: \(movie.status)"
        taglineLabel.text = "LEMA: \(movie.tagline ?? String())"
        descriptionLabel.text = movie.overview
        voteAverageLabel.text = "CALIFICACION: \(movie.vote_average) / 10.0"
        
    }
    
    func displayImage(_ image: UIImage) {
        backdropPathImage.image = image
    }
}

extension MovieDetailViewController {
    static var storyboardID: String {
        return String(describing: self)
    }
}
