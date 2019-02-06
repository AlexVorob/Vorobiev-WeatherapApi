//
//  WeatherManager.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/25/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

fileprivate struct Constant {

    static let weatherApi = "https://api.openweathermap.org/data/2.5/weather?q="
    static let weatherApiId = "&units=metric&APPID=ac6d05234841cc6b76ed2a4fcfda2b6b"

    static var getApiLink: (String) -> String = {
        return $0 + weatherApiId
    }
}

class WeatherNetworkService {
    
    private let networkService: RequestService?
    
    init(_ networkService: RequestService) {
        self.networkService = networkService
    }
    
    private func getURL(capital: String) -> URL? {
        let weatherPath = Constant.getApiLink(capital)
        
        return weatherPath
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .flatMap { URL(string: Constant.weatherApi + $0) }
    }
    
    public func modelFilling(country: ObservableWrapper<Country>) {
        guard let url = self.getURL(capital: country.unwrap.capital) else { return }
        
        self.networkService?.getData(from: url) { model, error in
            model
                .flatMap { try? JSONDecoder().decode(JSONWeather.self, from: $0) }
                .do { side(weather($0)) { weather in
                    country.update { $0.weather = weather }
                    }
            }
        }
    }
}

fileprivate let weather: (JSONWeather) -> Weather = {
    Weather(
        date: Date(timeIntervalSince1970: TimeInterval($0.dt)),
        temperature: $0.main.temp)
}
