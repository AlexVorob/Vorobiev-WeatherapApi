//
//  NetworkService.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class RequestService: RequestServiceType {
    
    public enum State {
        case didStartLoading
        case didLoad
        case didFailedWithError(_ error: Error?)
    }
    
    private(set) var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }

    public func sheduledTask(from url: URL, completion: @escaping (Result<Data, RequestServiceError>) -> ()) -> NetworkTask {
        let dataTask = self.session
            .dataTask(with: url) { (data, response, error) in
                completion(Result(value: data, error: error.map { .failed($0) }, default: .unknown))
        }

        defer {
            dataTask.resume()
        }
        
        return NetworkTask(urlSessionTask: dataTask)
    }
}

public enum RequestServiceError: Error {
    case unknown
    case failed(Error)
}

public protocol RequestServiceType {

    func sheduledTask(from url: URL, completion: @escaping (Result<Data, RequestServiceError>) -> ()) -> NetworkTask
}
