//
//  NetworkService.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class NetworkService<ModelData>: ObservableObject<NetworkService.State> where ModelData: Decodable {
    
    public enum State {
        case didStartLoading
        case didLoad
        case didFailedWithError(_ error: Error?)
    }
    
    private(set) var model: ModelData?
    
    public func dataLoad(from url: URL) {
        self.notify(state: .didStartLoading)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let dataParse = data.flatMap { try? JSONDecoder().decode(ModelData.self, from: $0) }
            dataParse.do { self.model = $0 }
            if error != nil {
                self.notify(state: .didFailedWithError(error))
            }
            self.notify(state: .didLoad)
        }.resume()
    }
}
