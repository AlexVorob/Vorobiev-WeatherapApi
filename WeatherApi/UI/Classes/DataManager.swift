//
//  DataManager.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/21/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

fileprivate struct Constant {
    
    static let countryApi = "https://restcountries.eu/rest/v2/all"
    static let weatherApi = "https://api.openweathermap.org/data/2.5/weather?q="
    static let weatherApiId = "&units=metric&APPID=ac6d05234841cc6b76ed2a4fcfda2b6b"
    
    static var getApiLink: (String) -> String = {
        return weatherApi + $0 + weatherApiId
    }
}

class DataManager<Value> where Value: Decodable {

    private let networkService = NetworkService<Value>()
    private let model = DataModel()
    
    public func loadData(from url: URL, execute: @escaping (Value?, Error?) -> ()) {
        self.networkService.dataLoad(from: url) { data, error in
            execute(data, nil)
        }
    }
}
