//
//  API.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 31/08/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import Foundation
import Alamofire

public enum API {
    case getMovie(id: Int)
    case getPopularMovies(page: Int)
    case getPathImage(path: String)
}

extension API: EndPointType {
    
    private var environmentBaseURL: String {
        return "https://api.themoviedb.org/3/movie/"
    }
    
    private var environmentBaseImageURL: String {
        return "https://image.tmdb.org/t/p/w500"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var baseImageURL: URL {
        guard let url = URL(string: environmentBaseImageURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getMovie(let id):
            return "\(id)"
        case .getPopularMovies:
            return "popular"
        case .getPathImage(let path):
            return "\(path)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getMovie, .getPopularMovies, .getPathImage:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getMovie:
            return ["api_key": NetworkManager.MovieAPIKey,
                    "language": "es-CO",
                    "region": "CO"]
        case .getPopularMovies(let page):
            return ["api_key": NetworkManager.MovieAPIKey,
                    "language": "es-CO",
                    "region": "CO",
                    "page": page]
        default:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getMovie, .getPopularMovies:
            return ["Accept": "application/json"]
        default:
            return nil
        }
    }
    
}
