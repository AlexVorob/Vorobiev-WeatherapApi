//
//  NetworkTask.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 2/12/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public class NetworkTask: Cancellable {
    
    public private(set) var isCancelled = false
    
    private let urlSessionTask: URLSessionTask
    
    public init(urlSessionTask: URLSessionTask) {
        self.urlSessionTask = urlSessionTask
    }
    
    public func cancel() {
        self.urlSessionTask.cancel()
        self.isCancelled = true
    }
}
