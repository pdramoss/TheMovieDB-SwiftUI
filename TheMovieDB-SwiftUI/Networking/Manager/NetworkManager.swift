//
//  NetworkManager.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 31/08/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case checkNetwork = "Please check your network connection."
}

enum Result<String> {
    case success
    case failure(String)
}

enum NetworkManagerError: Error {
    case notDecodeData
    case notParseData
}

protocol NetworkManagerProtocol {
    static var MovieAPIKey: String { get }
    var router: Router<API> { get }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
    
    func getMovie(id: Int, completion: @escaping (GetMovieCompletion))
    func getPopularMovies(page: Int, with completion: @escaping (GetPopularCompletion))
    func getImage(path: String, completion: @escaping (GetImageCompletion))
}

struct NetworkManager: NetworkManagerProtocol {
    static let MovieAPIKey = "18a3033e9791992fa76ae5c4071acd0f"
    var router: Router<API> = Router<API>()
    
    func load<T: Decodable> (data: Data?, as type: T.Type = T.self) throws -> T {
        guard let data = data else {
            throw NetworkManagerError.notDecodeData
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkManagerError.notParseData
        }
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
