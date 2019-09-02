//
//  GetMovieUseCase.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 31/08/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import Foundation

enum GetMovieResult {
    case success(FullMovie)
    case failure(String)
}

typealias GetMovieCompletion = (GetMovieResult) -> Void

extension NetworkManager {
    func getMovie(id: Int, completion: @escaping (GetMovieCompletion)) {
        router.request(.getMovie(id: id)) { (data, response, error) in
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
                        let movie: FullMovie = try self.load(data: responseData)
                        completion(.success(movie))
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
