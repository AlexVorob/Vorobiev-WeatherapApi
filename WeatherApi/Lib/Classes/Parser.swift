//
//  Parser.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class Parser<ModelData>: ObservableObject<Parser.State> where ModelData: Codable  {
    
    public enum State {
        case none
        case didStartLoading
        case didLoad
        case didFailedWithError(_ error: Error?)
    }
    
    private(set) var state = State.none {
        didSet {
            DispatchQueue.main.async {
                self.notify(state: self.state)
            }
        }
    }
    
    var model: ModelData?
    
    public func dataLoading(url: URL) {
        self.state = .didStartLoading
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let dataParse = data.flatMap { try? JSONDecoder().decode(ModelData.self, from: $0) }
            dataParse.do { self.model = $0 }
            self.state = .didLoad
        }.resume()
    }
}
