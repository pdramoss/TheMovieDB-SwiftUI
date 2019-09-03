//
//  Router.swift
//  TheMovieDB-UIKit
//
//  Created by Pedro Ramos on 31/08/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: HTTPURLResponse?,_ error: Error?) -> Void
public typealias NetworkRouterImageCompletion = (_ image: UIImage?,_ error: Error?) -> Void

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func requestImage(_ route: EndPoint, completion: @escaping NetworkRouterImageCompletion)
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let fullURL = route.baseURL.appendingPathComponent(route.path)
        
        Alamofire.request(fullURL, method: route.httpMethod ,parameters: route.parameters, headers: route.headers).responseData { response in
            switch response.result {
            case .success(let data):
                completion(data, response.response, nil)
                break
            case .failure(let error):
                completion(nil, nil, error)
                break
            }
        }
        
    }
    
    func requestImage(_ route: EndPoint, completion: @escaping NetworkRouterImageCompletion) {
        let fullURL =  route.baseImageURL.appendingPathComponent(route.path)
        
        Alamofire.request(fullURL).responseImage { response in
            switch response.result{
            case .success(let image):
                completion(image, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}
