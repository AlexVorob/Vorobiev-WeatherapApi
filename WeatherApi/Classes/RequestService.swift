//
//  NetworkService.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import Alamofire

class RequestService: RequestServiceType {
    
    private(set) var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }

    public func sheduledTask(
        from url: URL,
        completion: @escaping (Result<Data, RequestServiceError>) -> ()
    )
        -> NetworkTask
    {
        let request = Alamofire.request(url).response { response in
            completion(
                Result(
                value: response.data,
                error: response.error.map { .failed($0) },
                default: .unknown)
            )
        }

        defer {
            request.task?.resume()
        }
        
        return NetworkTask(urlSessionTask: request.task)
    }
}

public enum RequestServiceError: Error {
    case unknown
    case failed(Error)
}

public protocol RequestServiceType {

    func sheduledTask(from url: URL, completion: @escaping (Result<Data, RequestServiceError>) -> ()) -> NetworkTask
}
