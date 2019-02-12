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

    public func loadData(from url: URL, completion: @escaping (Data?, Error?) -> ()) -> NetworkTask {
        let dataTask = URLSession.shared
            .dataTask(with: url) { (data, response, error) in
               completion(data, error)
        }
        let networkTask = NetworkTask(urlSessionTask: dataTask)
        dataTask.resume()
        
        return networkTask
    }
}

protocol RequestServiceType {

    func loadData(from url: URL, completion: @escaping (Data?, Error?) -> ()) -> NetworkTask
}
