//
//  FullMovie.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 1/09/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI

struct FullMovie: Hashable, Codable, Identifiable {
    
    var id: Int
    var adult: Bool
    var budget: Int
    var genres: [Genres]
    var homepage: String?
    var imdb_id: String?
    var original_language: String
    var original_title: String
    var overview: String?
    var popularity: Float
    var poster_path: String?
    var production_companies: [Company]
    var production_countries: [Country]
    var release_date: String
    var revenue: Int
    var runtime: Int?
    var status: Status
    var tagline: String?
    var title: String
    var video: Bool
    var vote_average: Float
    var vote_count: Int
    var backdrop_path: String?
}

struct Genres: Hashable, Codable {
    var id: Int
    var name: String
}

struct Company: Hashable, Codable {
    var id: Int
    var name: String
    var logo_path: String?
    var origin_country: String
}

struct Country: Hashable, Codable {
    var iso_3166_1: String
    var name: String
}

enum Status: String, CaseIterable, Codable, Hashable {
    case rumored = "Rumored"
    case planned = "Planned"
    case inProduction = "In Production"
    case postProduction = "Post Production"
    case released = "Released"
    case canceled = "Canceled"
}
