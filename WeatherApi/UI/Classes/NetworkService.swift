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
    
    public func dataLoad(from url: URL, completion: @escaping (ModelData?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let dataParse = data.flatMap { try? JSONDecoder().decode(ModelData.self, from: $0) }
            completion(dataParse, nil)
            if error != nil {
                completion(nil, error)
            }
        }.resume()
    }
}
