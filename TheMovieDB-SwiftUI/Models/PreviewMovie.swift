//
//  Movie.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 31/08/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI

struct PreviewMovie: Hashable, Codable, Identifiable {
    
    var id: Int
    var poster_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Float
    var vote_count: Int
    var video: Bool
    var vote_average: Float
}
