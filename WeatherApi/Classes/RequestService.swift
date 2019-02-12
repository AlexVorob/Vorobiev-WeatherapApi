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
    
    var request: URLSessionDataTask?
    
    public func loadData(from url: URL, completion: @escaping (Data?, Error?) -> ()) {
        self.request = URLSession.shared
            .dataTask(with: url) { (data, response, error) in
               completion(data, error)
        }
        
        self.request?.resume()
    }
    
    func cancel() {
        self.request?.cancel()
    }
}

protocol RequestServiceType {
    
    var request: URLSessionDataTask? { get }
    
    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> ())
    
    func cancel()
}
