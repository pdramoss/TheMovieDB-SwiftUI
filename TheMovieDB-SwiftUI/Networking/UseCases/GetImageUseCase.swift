//
//  GetImageUseCase.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 1/09/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import UIKit

enum GetImageResult {
    case success(UIImage)
    case failure(String)
}

typealias GetImageCompletion = (GetImageResult) -> Void

extension NetworkManager {
    func getImage(path: String, completion: @escaping (GetImageCompletion)) {
        router.requestImage(.getPathImage(path: path)) { (image, error) in
            if let _ = error {
                completion(.failure(NetworkResponse.noData.rawValue))
            }
            if let image = image {
                completion(.success(image))
            }
        }
    }
}
