//
//  DataManager.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class DataManager<Value> where Value: Decodable {

    private let networkService = NetworkService<Value>()
    private let model = Model()
    
    public func loadData(from url: URL, execute: @escaping (Value?, Error?) -> ()) {
        self.networkService.dataLoad(from: url)
        
        self.networkService.observer {
            switch $0 {
            case .didStartLoading:
                return
            case .didLoad:
                execute(self.networkService.model, nil)
            case .didFailedWithError(let error):
                execute(nil, error)
            }
        }
    }
}
