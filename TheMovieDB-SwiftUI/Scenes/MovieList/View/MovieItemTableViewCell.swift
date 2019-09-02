//
//  MovieItemTableViewCell.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 1/09/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var averageLabel: UILabel!
    
    static var cellReuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: cellReuseIdentifier, bundle: nil)
    }
    
    func setupData(movie: PreviewMovie) {
        customPoster(movie.poster_path)
        customText(movie)
    }
    
    func customPoster(_ posterPath: String? ) {
        guard let path = posterPath else {
            return
        }
        
        DispatchQueue.main.async {
            NetworkManager().getImage(path: path, completion: { (result) in
                switch result {
                case .success(let image):
                    self.posterImage.image = image
                case .failure(let error):
                    print("ERROR: \(error)")
                }
            })
        }
    }
    
    func customText(_ movie: PreviewMovie) {
        self.titleLabel.text = movie.title
        self.averageLabel.text = "\(movie.vote_average) / 10.0"
    }
    
}
