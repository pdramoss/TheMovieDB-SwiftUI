//
//  MovieList.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 31/08/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import Foundation
import CoreLocation

struct MovieList: Hashable, Codable {
    var page: Int
    var results: [PreviewMovie]
    var total_results: Int
    var total_pages: Int
}
