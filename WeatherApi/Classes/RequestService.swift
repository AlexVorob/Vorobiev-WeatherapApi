//
//  NetworkService.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class RequestService {
    
    public enum State {
        case didStartLoading
        case didLoad
        case didFailedWithError(_ error: Error?)
    }
    
    public func getData(from url: URL, completion: @escaping (Data?, Error?) -> ()) {
        URLSession.shared
            .dataTask(with: url) { (data, response, error) in
               completion(data, error)
        }
            .resume()
    }
}
