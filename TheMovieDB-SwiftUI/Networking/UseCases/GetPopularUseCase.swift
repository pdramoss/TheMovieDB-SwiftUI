//
//  GetPopularUseCase.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 31/08/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import Foundation

enum GetPopularMoviesResult {
    case success(MovieList)
    case failure(String)
}

typealias GetPopularCompletion = (GetPopularMoviesResult) -> Void

extension NetworkManager {
    func getPopularMovies(page: Int, completion: @escaping (GetPopularCompletion)) {
        router.request(.getPopularMovies(page: page)) { (data, response, error) in
            if let _ = error {
                completion(.failure(NetworkResponse.checkNetwork.rawValue))
            }
            
            if let response = response {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NetworkResponse.noData.rawValue))
                        return
                    }
                    do {
                        let movieList: MovieList = try self.load(data: responseData)
                        completion(.success(movieList))
                    } catch {
                        completion(.failure(NetworkResponse.unableToDecode.rawValue))
                    }
                case .failure(let networkFailureError):
                    completion(.failure(networkFailureError))
                }
            }
        }
    }
}
