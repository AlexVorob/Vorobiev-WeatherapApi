//
//  ManagerController.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class ManagerController<Model> where Model: Decodable {
    
    private var observers = [ObservableObject<Model>.Observer]()
    
    private let networkService = NetworkService<Model>()
    
    public func loadData(from url: URL, execute: @escaping (Model?, Error?) -> ()) {
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
